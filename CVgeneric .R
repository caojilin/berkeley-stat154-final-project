CVgeneric <- function(classifier, features, labels, K=5, loss_fn=NULL, 
                      model_input) {
  folds <- createFolds(1:nrow(features), k = K)
  output <- data.frame(Folds = c(1:K), accuracy = rep(0, K), loss= rep(0, K))
  loss <- rep(0, K)
  accuracy = rep(0, K)
  dat = cbind(features, labels)
  for (i in 1: K) {
    train.cv = dat[-folds[[i]],]
    test.cv = dat[folds[[i]],]
    train.label = labels[-folds[[i]],]
    test.label = labels[folds[[i]],]
    if (classifier == "logistic") {
      mod_fit = glm(model_input, data = train.cv, family = "binomial")
      y_hat = predict(mod_fit, test.cv, type="response")
      y_hat = y_hat > 0.5
      y_hat[which(y_hat == FALSE)] <- 0
      y_hat[which(y_hat == TRUE)] <- 1
      
    }else if (classifier == "qda") {
      mod_fit <- qda(model_input, data = train.cv)
      y_hat = predict(mod_fit, test.cv)$class
    }else if (classifier == "lda") {
      mod_fit <- lda(model_input, data = train.cv)
      y_hat = predict(mod_fit, test.cv)$class
    }else{
      mod_fit <- train(model_input, data = train.cv, method=classifier)
      y_hat = predict(mod_fit, test.cv)
    } 
    # output[i,3] = loss_fn(y_hat, train.label)
    output[i,2] = mean(y_hat == test.label)
  }
  return(output)
}