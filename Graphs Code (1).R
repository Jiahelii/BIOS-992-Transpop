library(tidyverse)
install.packages("reshape2")
library(reshape2)

grDevices::colors()

conditions = read.csv("graph.csv")

cholesterol = data.frame(
  gender_id = c("Cisgender Man", "Cisgender Woman", "Transgender Man", "Transgender Woman", "Non-binary Person"),
  cis_trans = c("Cis", "Cis", "Trans", "Trans", "Trans"),
  cases_percent = c(34.71, 32.18, 20.51, 29.17, 18.42)
)

chol_graph = ggplot(data = cholesterol, aes(x = gender_id, y = cases_percent, fill = gender_id)) + ggtitle("High Cholesterol by Gender Identity") +
             geom_col(col = "grey50") + scale_fill_manual('Gender Identity', values=c('lightblue',"lightpink", "white", "lightpink", "lightblue")) + 
             theme_bw() + labs(x = "Gender Identity", y = "Percent with High Cholesterol") + theme(plot.title = element_text(hjust = 0.5)) + 
             theme(plot.title = element_text(size = 25)) + theme(axis.title = element_text(size = 15)) + 
             theme(axis.text=element_text(size=12)) +   theme(legend.position="none") + scale_y_continuous(expand = expansion(mult = c(0, 0.05))) 

chol_graph



# Create labels
boxLabels = c("Hypertension", "Cholesterol")

# Enter summary data. boxOdds are the odds ratios (calculated elsewhere), boxCILow is the lower bound of the CI, boxCIHigh is the upper bound.

df <- data.frame(
  yAxis = length(boxLabels):1,
  boxOdds = c(0.361, 0.621),
  boxCILow = c(0.263, 0.495),
  boxCIHigh = c(0.458, 0.841)
)
df

# Plot
p <- ggplot(df, aes(x = boxOdds, y = yAxis))
p = p + geom_vline(aes(xintercept = 1), linewidth = .25, linetype = "dashed") +
  geom_errorbarh(aes(xmax = boxCIHigh, xmin = boxCILow), size = .5, height = .2, color = "gray50") +
  geom_point(size = 3.5, color = "lightpink") +
  theme_bw() +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = df$yAxis, labels = boxLabels) +
  ylab("") + 
  xlab("Odds Ratio") + 
  ggtitle("Odds Ratios for Transgender vs Cisgender Subjects") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(plot.title = element_text(size = 20)) + theme(axis.title = element_text(size = 15)) + 
  theme(axis.text=element_text(size=13))

p
