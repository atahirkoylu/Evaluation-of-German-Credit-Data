# Evaluation of German Credit Data

In this project, an ensemble model was developed to predict credit scores using the "German Credit Scoring" dataset.

# Project Objective
The objective of this project is to develop an ensemble model to predict credit scores using the "German Credit Scoring" dataset. The project specifically aims to:

Utilize three machine learning algorithms: Generalized Linear Model (GLM), Random Forest, and RPart (Recursive Partitioning).

Combine the predictions from these models into a custom ensemble using a simple summation approach (algo_sum) instead of relying on external ensemble packages like SuperLearner.

Compare the performance of this custom ensemble model to individual models and the SuperLearner ensemble to evaluate improvement in classification accuracy.

# Project Questions

How accurate is each individual model (GLM, Random Forest, RPart) in predicting the credit score?

What is the performance of the custom ensemble model based on the combined prediction rule (algo_cat = ifelse(algo_sum >= 2, 1, 0))?

How does the custom ensemble model's confusion matrix compare to those of the individual models?

Does the SuperLearner ensemble outperform the individual models?

Does the simple custom ensemble (algo_sum) provide any improvement over individual model predictions?

What impact does converting the score to a binary variable (1/0) have on model performance and interpretability?

# Conclusion

The project demonstrated that combining multiple classification algorithms using a simple ensemble approach (algo_sum) can improve predictive performance over using individual models alone. The confusion matrices revealed that:

Each model (GLM, RF, RPart) has varying levels of accuracy.

The custom ensemble model (algo_cat) showed improved predictive capability when using a majority-vote logic (i.e., 2 out of 3 models agree).

The SuperLearner ensemble also performed well and can serve as a benchmark for ensemble modeling.

This project highlights the benefits of ensemble techniques in predictive analytics, especially when complex ensemble libraries are not used, and emphasizes the importance of evaluating multiple models to enhance credit scoring accuracy.

![Dashboard](https://github.com/atahirkoylu/Evaluation-of-German-Credit-Data/blob/main/1.png)

![Dashboard](https://github.com/atahirkoylu/Evaluation-of-German-Credit-Data/blob/main/2.png)

![Dashboard](https://github.com/atahirkoylu/Evaluation-of-German-Credit-Data/blob/main/3.png)

![Dashboard](https://github.com/atahirkoylu/Evaluation-of-German-Credit-Data/blob/main/4.png)

![Dashboard](https://github.com/atahirkoylu/Evaluation-of-German-Credit-Data/blob/main/5.png)

