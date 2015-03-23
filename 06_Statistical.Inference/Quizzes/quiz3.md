# Statistical Inference: Quiz 3
Marcos Gestal  


---

### Question 1

In a population of interest, a sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is a 95% Student's T confidence interval for the mean brain volume in this new population?


#### Solution

Assuming underlying data is iid gaussian, then $\frac{\overline{X}-\mu}{^S/_\sqrt{n}}$ follows a t distribution with n-1 degress of freedom.

The required confidence interval is $\overline{X} \pm t_{n-1}·\frac{S}{\sqrt{n}}$



```r
mu <- 1100
sigma <- 30
n <- 9

mu + c(-1, 1) * qt(0.975, df = n - 1) * sigma/sqrt(n)
```

```
## [1] 1076.94 1123.06
```


### Question 2

A diet pill is given to 9 subjects over six weeks. The average difference in weight (follow up - baseline) is -2 pounds. What would the standard deviation of the difference in weight have to be for the upper endpoint of the 95% T confidence interval to touch 0?


$\overline{X} \pm t_{n-1}·\frac{S}{\sqrt{n}}$

$CI_{upper} = \overline{X} + t_{n-1}·\frac{S}{\sqrt{n}}$

S = $\frac{(CI_{upper}-\overline{X})*\sqrt{n}}{t_{n-1}}$ 


```r
mu <- -2
n <- 9
p <- 0.975
ci_upper = 0; 

sd <- ((ci_upper - mu )* sqrt(n)) / qt(p, df=n-1)
sd
```

```
## [1] 2.601903
```

### Question 3

In an effort to improve running performance, 5 runners were either given a protein supplement or placebo. Then, after a suitable washout period, they were given the opposite treatment. Their mile times were recorded under both the treatment and placebo, yielding 10 measurements with 2 per subject. The researchers intend to use a T test and interval to investigate the treatment. Should they use a paired or independent group T test and interval?

- It's necessary to use both  		
- **A paired interval**
- You could use either			
- Independent groups, since all subjects were seen under both systems


#### Explanation

Both treatments are applied to the same subjects so paired test should be applied.

### Question 4

In a study of emergency room waiting times, investigators consider a new and the standard triage systems. To test the systems, administrators selected 20 nights and randomly assigned the new triage system to be used on 10 nights and the standard system on the remaining 10 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 3 hours with a variance of 0.60 while the average MWT for the old system was 5 hours with a variance of 0.68. Consider the 95% confidence interval estimate for the differences of the mean MWT associated with the new system. Assume a constant variance. What is the interval? Subtract in this order (New System - Old System).

- [1.25, 2.75]  		
- **[-2.75, -1.25]**	
- [1.29, 2.70]			
- [-2,70, -1.29]


#### Explanation


```r
n1 <- 10 
mu1 <- 5 
sd1 <- 0.68 

n2 <- 10 
mu2 <- 3
sd2 <- 0.6 

p <- 0.975   # 95% confidence interval with 2.5% on both sides of the range

SE <- sqrt( ((n2-1) * sd2 + (n1-1) * sd1) / (n1 + n2 - 2) )

mu2 - mu1 + c(-1,1) * qt(p, df=(n1+n2-2)) * SE * sqrt(1/n1 + 1/n2) 
```

```
## [1] -2.751649 -1.248351
```

### Question 5

Suppose that you create a 95% T confidence interval. You then create a 90% interval using the same data. What can be said about the 90% interval with respect to the 95% interval?

- The interval will be the same width, but shifted.			
- The interval will be wider			
- **The interval will be narrower**
- It is impossible to tell.


#### Explanation


```r
n1 <- 10 
mu1 <- 5 
sd1 <- 0.68 

n2 <- 10 
mu2 <- 3
sd2 <- 0.6 

p <- 0.95   # 90% confidence interval with 5% on both sides of the range

SE <- sqrt( ((n2-1) * sd2 + (n1-1) * sd1) / (n1 + n2 - 2) )

mu2 - mu1 + c(-1,1) * qt(p, df=(n1+n2-2)) * SE * sqrt(1/n1 + 1/n2) 
```

```
## [1] -2.620397 -1.379603
```

### Question 6

To further test the hospital triage system, administrators selected 200 nights and randomly assigned a new triage system to be used on 100 nights and a standard system on the remaining 100 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 4 hours with a standard deviation of 0.5 hours while the average MWT for the old system was 6 hours with a standard deviation of 2 hours. Consider the hypothesis of a decrease in the mean MWT associated with the new treatment. What does the 95% independent group confidence interval with unequal variances suggest vis a vis this hypothesis? (Because there's so many observations per group, just use the Z quantile instead of the T.)

- **When subtracting (old - new) the interval is entirely above zero. The new system appears to be effective.**	
- When subtracting (old - new) the interval is entirely above zero. The new system does not appear to be - effective.			
- When subtracting (old - new) the interval contains 0. The new system appears to be effective.			
- When subtracting (old - new) the interval contains 0. There is not evidence suggesting that the new system is effective.	


#### Explanation


```r
n1 <- 100   # old system
mu1 <- 6
sd1 <- 2 

n2 <- 100   # new system
mu2 <- 4
sd2 <- 0.5 

p <- 0.975   # 95% confidence interval with 2.5% on both sides of the range

SE <- sqrt( ((n2-1) * sd2^2 + (n1-1) * sd1^2) / (n1 + n2 - 2) )

mu1 - mu2 + c(-1,1) * qnorm(p) * SE * sqrt(1/n1 + 1/n2)
```

```
## [1] 1.595943 2.404057
```

### Question 7

Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects' body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was -3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI over the four week period appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, calculate the relevant *90%* t confidence interval. Subtract in the order of (Treated - Placebo) with the smaller (more negative) number first.

- [2.469, 5.531]  		
- [2.636, 5.364]			
- [-5.531, -2.469]			
- **[-5.364, -2.636]**


#### Explanation


```r
n1 <- 9
n2 <- 9

mu1 <- -3  #treated
sd1 <- 1.5 

mu2 <- 1   #placebo
sd2 <- 1.8  

p <- 0.95   # 90% confidence interval with 5% on both sides of the range

SE <- sqrt( ((n2-1) * sd2^2 + (n1-1) * sd1^2) / (n1 + n2 - 2) )

mu1 - mu2 + c(-1,1) * qt(p, df=(n1+n2-2)) * SE * sqrt(1/n1 + 1/n2)
```

```
## [1] -5.363579 -2.636421
```
