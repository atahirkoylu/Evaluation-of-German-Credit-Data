# Final 
# FAll 2023
# R Portion


setwd("C:/Users/arodriguez/Dropbox/classes/DataMining_FALL23/Knime_Part2")

# =============================  #

# Prepare an "ensemble" model to predict Score (i.e. credit score).  

    # Use GLM, random forests, and RPart. 
    # Split into training and testing sets.  
    # Use the data set "german-credit-scoring"

# But rather than use SuperLearner or any ensemble package please calculate a 
# simple sum of the predicted scores of the three algos ("algo_sum").

          # e.g. "algo_sum = glm_pred + rf_pred + rpart_pred"

# This entails running each algo separately; extracting the "Score" prediction 
# for each algo;
# Then you sum the three Score vectors (e.g. "algo_sum").  

# with the algo sum use the following decision rule to obtain 
# the combined score (e.g. "algo_cat").

    #     algo_sum = glm_pred + rf_pred + rpart_pred
    #     algo_cat = ifelse(algo_sum >=2, 1, 0)
    
    # and then the confusion matrix for the combined score
    
    #     mean(algo_cat == test$Score) 
    
    # below is calculate 
    #     mean(ensemble_pred == test$Score) # the score from the SuperLearner estimate

    # I reproduce the SuperLearner results below for you to compare
    # your "algo_sum" to the ensemble score prediction obtained from
    # SuperLearner ("ensemble_pred")
  
# Use GLM, random forests, and RPart. Split into training and testing sets.  
# Use the data set "german-credit-scoring"
    # in your work
# 1. Show the confusion matrix for the GLM alone.
    
    # e.g.  "mean(pred_glm == test$Score)"
    
# 2. Show the confusion matrix for the Random Forest classification alone.
# 3. Show the confusion matrix for the RPart classification alone.
# 5. Show the confusion matrix for the ensemble model.

# Consider: did the SuperLearner ensemble improve over the individual models? 
# Consider: did your own ensemble improve over the individual models? 

# KNIT your code to html and upload the html file to the bucket 
# titled: Admissions_Ensemble
# By May 17th, cob.

# Hint: change the binary (2/1) to binary(1/0); 'cause its easier
        # credit$Score = credit$Score - 1

#=====================================================================#

      remove(list = ls())
      graphics.off()
      options(digits = 3, scipen = 999999)
      suppressPackageStartupMessages({
      library(tidyverse)
      library(SuperLearner)
      library(magrittr)
      })

credit = read.csv("german-credit-scoring.csv", header = TRUE, 
                  stringsAsFactors = TRUE,
                  sep = ";"
                  )

        head(credit)
        glimpse(credit)
        colSums(is.na(credit))

        table(as.numeric(credit$Score))
        
        credit$Score = as.numeric(as.factor(credit$Score))
        credit$Score = credit$Score - 1
            table(credit$Score)

            names(credit)
                  credit$id = 1:nrow(credit)
                  train = credit %>% sample_frac(0.7)
                  test = credit %>% anti_join(train, by = "id")
                  train %<>% dplyr::select(-id)
                  test %<>% dplyr::select(-id)
                  credit %<>% dplyr::select(-id)

names(train)

#Fitting the Super Learner ========================
set.seed(123456)

SL.library <- c("SL.glm", 
                "SL.randomForest", 
                "SL.rpart"
                #,"SL.biglasso"
                )

          ensemble.model <- SuperLearner(
            Y = train$Score, 
            X = train[,c(1:20)],
            verbose = TRUE,
            SL.library = SL.library,
            method = "method.NNLS2"
            )

  ensemble.model

        #Predictions of the SuperLearner ================ 
        predictions <- predict.SuperLearner(ensemble.model, newdata=test[,c(1:20)])
        head(predictions$pred)  # ensemble prediction
        head(predictions$library.predict) # individual model predictions

        # Recode probabilities ================
        hist(predictions$pred)
        ensemble_pred = ifelse(predictions$pred>=median(predictions$pred),1,0) # at medians
        
        hist(predictions$library.predict[,1])
        glm_pred = predictions$library.predict[,1]
        glm_pred = ifelse(glm_pred>=median(glm_pred),1,0)
        table(glm_pred)
        
        hist(predictions$library.predict[,2])
        rf_pred = predictions$library.predict[,2]
        rf_pred = ifelse(rf_pred>=median(rf_pred),1,0)
        table(rf_pred)
        
        hist(predictions$library.predict[,3])
        rpart_pred = predictions$library.predict[,3]
        rpart_pred = ifelse(rpart_pred>=median(rpart_pred),1,0)
        table(rpart_pred)


# Accuracy of Predictions: Individual and Ensemble ==========
cm_ensemble <- caret::confusionMatrix(as.factor(ensemble_pred), 
                                      as.factor(test$Score))
    cm_ensemble

cm_glm <- caret::confusionMatrix(as.factor(glm_pred), 
                                 as.factor(test$Score))
    cm_glm

cm_rf <- caret::confusionMatrix(as.factor(rf_pred), 
                                as.factor(test$Score))
    cm_rf

cm_rpart <- caret::confusionMatrix(as.factor(rpart_pred), 
                                as.factor(test$Score))
    cm_rpart


# Visuals =================
    ## Base R =============
mydata = data.frame(Ensemble = mean(ensemble_pred == test$Score),
           GLM = mean(glm_pred == test$Score),
           RF = mean(rf_pred == test$Score),
           RPart = mean(rpart_pred == test$Score)
           )
mydata
barplot(as.matrix(mydata), 
        names.arg=colnames(mydata))

   ## ggplot =============
mydata %>% pivot_longer(cols = everything(), 
                        names_to = "Algo", values_to = "Value")  %>%
  ggplot(aes(x = Algo, y = Value, fill = Algo)) + 
  geom_col(show.legend = FALSE) + 
  ylim(0,0.75)+
  geom_text(aes(label = round(Value,3)), 
            vjust = 1.5, 
            hjust = -0.75,
            colour = "darkred") +
  coord_flip()

# ====================  #

