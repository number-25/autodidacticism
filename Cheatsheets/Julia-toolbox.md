# Julia ToolBox 

## Cool quotes and statements

"Wrapping a piece of code up in a function is called encapsulation. One of the benefits of encapsulation is that it attaches a name to the code, which serves as a kind of documentation. Another advantage is that if you re-use the code, it is more concise to call a function twice than to copy and paste the body!"     

## Statistics and Distributions 

### Random generators 

Before generating and pseudo-random numbers, we must prompt julia to generate a
replicable 'seed' of random numbers, so that we can share this with others who
may seek to reproduce our workflows.     

I am not sure if this comes with Julia base, or we are required to load the package "RandomNumbers.jl"   
`Random.seed!(123434)`   

If we want to generate a set of random replicates from say, a distribution, we can use the convenient *rand* function.  

The following example will generate a set containing a single 'experiment'
which tallies (in this particular case) the number of successes within a 15
bernoulli trials - in other words, how many times did head comes up if we
flipped a fair coin 15 times!   
`rand(Binomial(15, 0.5)`   

We can replicate this set itself, and run the experiment another 15 times, to see the general flux of successes in repeated bernoulli trials.   
`random(Binomial(15, 0.5), 1000)`      

Generate random vector of numbers with a mean of 0 and a standard deviation of 1.
`randn(100,5)` # 100 by 5 matrix 




### Sampling 

The Stats.Base package allows us to *sample* specified values from specific probability frequencies, say, sample A and G which occur at 1/3 and 2/3 probability.  
The function **ProbabilityWeights** is a game changer --- below we will take 100 values from the provided set from given weights.   
```julia
x = ["A" "G" "C" "T"] 
samples(x, ProbabilityWeights[(1/8, 3/8, 3/8, 1/8)], 100)
```

### Probability mass and density functions 

A probability mass function gives the value of a **discerte** random variable
under a specific distribution. A probability density function gives theis
value for a **continuously** disributed variable.    

PDF
```julia
pdf(<Distribution(param), value)
```


### Binomial

Using any of the probability distributions, we must preload  the *Distributions.jl* package.    

Let's generation a binomial distribution with 20 trials, and slightly biased failure rate. The general structure of this function is **Binomial(trial number, success rate)**.    
```julia
using Distributions
Binomial(20, 0.45)
```

### Point Estimation and Estimation

### Maximum Likelihood Estimation 
The Distribution.jl package provides a convenient function for computing the
MLE for a given probability distribution, and the sample distribution.   
    
`fit_mle(Poisson, real)`    



## Writing to Files 

Write a vector of values to a file using the DelimitedFiles package. 
```julia
using DelimitedFiles
array = rand(10:100, 50)
writedlm("sample.txt", array) 
```

Write the contents of a file to another file - input/output
```julia
io = open("test.txt", "w") do io
  for x in y
    println(io, x)
  end
end
``` 



## STDIN

Read all lines from an input stream 
```julia
stream = STDIN
for line in eachline(stream)
    print("Found $line")
    # process the line
end
```

Test whether you have reached the end of an input stream - use `eof(stream` in combination with a while loop
```julia
  while !eof(stream)
       x = read(stream, Char)
       println("Found: $x") 
# process the character
end
```

## Formatting 
### Sub and super scripts

The subscript numbers are available in the Unicode character encoding ( \_1 TAB
, \_2 TAB , etc.).

On the other hand, superscript is denoted with ( \^1 TAB, \_^3 TAB ). 


## Basic Parsing, Descriptive Stats, Tallys and so on 

### Summaries
Create a basic dict containing a tally of all the elements in a vector - this
is handy for counting the frequency of count data. E.g. how many times 0
occurs, 1, 2 and so on. This is similar to R's function **table()**.

```julia
real = rand(Poisson(0.5), 100)
countmap(real)
```

**enumerate** 

## Functions 

### One liners To execute a function over a subset of values in a set, rather
than righting a for loop and iterating, we can use the 'one liner' notation as
such. x will be our variable, and we will execute the function filter, so
filter values of x, such that the dayname of x is Monday in the dataset
calendar. For this to evaluate to true, there must be daynames in calendar
which are called Monday

```julia
filter(x -> Dates.daynames(x) == "Monday", calendar)
```










