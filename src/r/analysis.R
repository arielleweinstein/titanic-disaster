library(tidyverse)
library(dplyr)
print("Loading in train data")
train <- read_csv("src/data/train.csv")
print("Train data loaded")
PassengerId <- train$PassengerId
Survived <- train$Survived
Pclass <- train$Pclass
Name <- train$Name
Sex <- train$Sex
Age <- train$Age
SibSp <- train$SibSp
Parch <- train$Parch
Ticket <- train$Ticket
Fare <- train$Fare
Cabin <- train$Cabin
Embarked <- train$Embarked

print("Group the age column by class and sex and fill in the NaN values with the median of each group")
train <- train %>%
  group_by(Pclass, Sex) %>%
  mutate(Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age)) %>%
  ungroup()

print("Select feature columns as Pclass, Sex, Age, SibSp, Parch, and Fare.")
print("Map male to 1 and female to 0 to avoid NaN error in the model for train data")
train <- train %>%
  mutate(Sex = recode(Sex, "male" = 1, "female" = 0))

print("Set up model as logistic regression with Survived as the target variable and inputs as feature columns.")
model <- glm(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare,
             data = train,
             family = "binomial")

print('Making predictions for survival based on training data')
y_pred_prob <- predict(model, newdata = train, type = "response")
print("Sorting probabilities into 1s and 0s")
y_pred <- ifelse(y_pred_prob >= 0.5, 1, 0)
print('Calculating accuracy based on comparison between predictions and target variable data')
accuracy <- mean(y_pred == train$Survived)
print(paste("Accuracy = ", accuracy))

print('Loading in test csv file')
test <- read_csv("src/data/test.csv")
print('Test csv file loaded')
PassengerId_t <- test$PassengerId
Pclass_t <- test$Pclass
Name_t <- test$Name
Sex_t <- test$Sex
Age_t <- test$Age
SibSp_t <- test$SibSp
Parch_t <- test$Parch
Ticket_t <- test$Ticket
Fare_t <- test$Fare
Cabin_t <- test$Cabin
Embarked_t <- test$Embarked

print("Group the age column by class and sex and fill in the NaN values with the median of each group")
test <- test %>%
  group_by(Pclass, Sex) %>%
  mutate(Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age)) %>%
  ungroup()

print("Map male to 1 and female to 0 to avoid NaN error in the model for test data")
test <- test %>%
  mutate(Sex = recode(Sex, "male" = 1, "female" = 0))

print("Fill the 1 NaN fare with the mean of the fares to avoid NaN error in the model for test data")
test <- test %>%
  mutate(Fare = ifelse(is.na(Fare), mean(Fare, na.rm = TRUE), Fare))

print('Create new column in the test data for the model predictions "Survived" based on the test data')
test$Survived <- predict(model, newdata = test, type = "response")
print("Set probabilities to 0s and 1s to indicate survival")
test$Survived <- ifelse(test$Survived >= 0.5, 1, 0)
print("Write results to a csv")
write.csv(test[, c("PassengerId", "Survived")], "prediction_file_R.csv", row.names = FALSE)
