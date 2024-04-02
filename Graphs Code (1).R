library(tidyverse)
install.packages("reshape2")
library(reshape2)

grDevices::colors()

# Create labels
significant = c('lightpink', 'lightblue', 'lightpink', 'lightpink', 
           'lightblue', 'lightblue', 'lightblue', 'lightpink', 'lightpink', 'lightpink',
           'lightpink', 'lightblue', 'lightblue', 'lightblue', 'lightblue', 
           'lightblue', 'lightpink')

boxLabels = c("Hypertension", "High Cholesterol", "Heart Condition", "Heart Attack",
              "Emphysema", "Asthma", "Ulcer", "Cancer", "Diabetes", "Pre-Diabetes", 
              "Arthritis", "Blood Clot", "Osteoporosis", "Thyroid Disease", "Liver Disease",
              "COPD", "Crohn's Disease")

# Enter summary data. boxOdds are the odds ratios (calculated elsewhere), boxCILow is the lower bound of the CI, boxCIHigh is the upper bound.

df <- data.frame(
  yAxis = length(boxLabels):1,
  boxOdds = c(0.82, 1.50, 1.08, 1.68, 3.86, 1.75, 3.26, 0.88, 1.17, 1.37, 1.44, 2.99, 1.84, 1.77, 5.68, 2.72, 2.03),
  boxCILow = c(0.57, 1.05, 0.62, 0.78, 1.60, 1.16, 1.83, 0.47, 0.71, 0.88, 0.99, 1.45, 1.01, 1.17, 2.55, 1.38, 0.77),
  boxCIHigh = c(1.17, 2.13, 1.87, 3.64, 9.38, 2.63, 5.82, 1.65, 1.95, 2.12, 2.10, 6.17, 3.36, 2.68, 12.61, 5.39, 5.37)
)
df

# Plot
p <- ggplot(df, aes(x = boxOdds, y = yAxis))
p = p + geom_vline(aes(xintercept = 1), linewidth = .25, linetype = "dashed") +
  geom_errorbarh(aes(xmax = boxCIHigh, xmin = boxCILow), size = .5, height = .2, color = "black") +
  geom_point(size = 5, col = significant) +
  theme_bw() +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = df$yAxis, labels = boxLabels) +
  ylab("") + 
  xlab("Odds Ratio") + 
  ggtitle("Odds Ratios for Transgender vs Cisgender Subjects") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(plot.title = element_text(size = 15)) + theme(axis.title = element_text(size = 15)) + 
  theme(axis.text=element_text(size=13))
p

p = p + geom_text(aes(x = 11, y = 16.6, label = "Significant = "), color = "black", stat="unique", size = 5) +
  geom_point(aes(x = 12.1, y = 16.55), col = "lightblue", size = 5) + 
  geom_text(aes(x = 10.65, y = 15.6, label = "Non-Significant = "), color = "black", stat="unique", size = 5) +
  geom_point(aes(x = 12.1, y = 15.55), col = "lightpink", size = 5)

p = p + geom_text(aes(x = 2.2, y = 17, label = "0.82 (0.57, 1.17)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 3.1, y = 16, label = "1.50 (1.05, 2.13)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 2.8, y = 15, label = "1.08 (0.62, 1.87)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 4.6, y = 14, label = "1.68 (0.78, 3.64)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 10.4, y = 13, label = "3.86 (1.60, 9.38)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 3.6, y = 12, label = "1.75 (1.16, 2.63)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 6.8, y = 11, label = "3.26 (1.83, 5.82)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 2.7, y = 10, label = "0.88 (0.47, 1.65)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 2.9, y = 9, label = "1.17 (0.71, 1.95)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 3.1, y = 8, label = "1.37 (0.88, 2.12)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 3.1, y = 7, label = "1.44 (0.99, 2.10)"), size = 3.5, color="lightpink") +
    geom_text(aes(x = 7.2, y = 6, label = "2.99 (1.45, 6.17)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 4.4, y = 5, label = "1.84 (1.01, 3.36)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 3.7, y = 4, label = "1.77 (1.17, 2.68)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 13.6, y = 3, label = "5.68 (2.55, 12.61)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 6.4, y = 2, label = "2.72 (1.38, 5.39)"), size = 3.5, color="lightblue") +
    geom_text(aes(x = 6.4, y = 1, label = "2.03 (0.77, 5.37)"), size = 3.5, color="lightpink") +
    coord_cartesian(xlim = c(0, 14))

p  
