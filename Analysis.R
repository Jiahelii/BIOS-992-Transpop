# import data 
trans = read.csv("Clean_data.csv")
head(trans)


#logistic regression models

trans$ulcer = as.factor(trans$ulcer)
trans$ulcer = relevel(trans$ulcer, ref = "No")
ulcer <- glm(ulcer~trans_status, family='binomial', data=trans)
summary(ulcer)
exp(cbind(Odds_Ratio = coef(ulcer), confint(ulcer)))


trans$cancer = as.factor(trans$cancer)
trans$cancer = relevel(trans$cancer, ref = "No")
cancer <- glm(cancer~trans_status, family='binomial', data=trans)
summary(cancer)
exp(cbind(Odds_Ratio = coef(cancer), confint(cancer)))


trans$diabetes = as.factor(trans$diabetes)
trans$diabetes = relevel(trans$diabetes, ref = "No")
diabetes <- glm(diabetes~trans_status, family='binomial', data=trans)
summary(diabetes)
exp(cbind(Odds_Ratio = coef(diabetes), confint(diabetes)))


trans$pre_diabetes = as.factor(trans$pre_diabetes)
trans$pre_diabetes = relevel(trans$pre_diabetes, ref = "No")
pre_diabetes <- glm(pre_diabetes~trans_status, family='binomial', data=trans)
summary(pre_diabetes)
exp(cbind(Odds_Ratio = coef(pre_diabetes), confint(pre_diabetes)))


trans$arthritis = as.factor(trans$arthritis)
trans$arthritis = relevel(trans$arthritis, ref = "No")
arthritis <- glm(arthritis~trans_status, family='binomial', data=trans)
summary(arthritis)
exp(cbind(Odds_Ratio = coef(arthritis), confint(arthritis)))


trans$blood_clot = as.factor(trans$blood_clot)
trans$blood_clot = relevel(trans$blood_clot, ref = "No")
blood_clot <- glm(blood_clot~trans_status, family='binomial', data=trans)
summary(blood_clot)
exp(cbind(Odds_Ratio = coef(blood_clot), confint(blood_clot)))
