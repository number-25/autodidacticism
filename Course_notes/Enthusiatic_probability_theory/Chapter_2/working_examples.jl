# Simulating the example problems for Chapter 2

# Assuming these packages are installed on system
using Random, Plots, StatsBase, Statistics

Random.seed!(12345)

"""
Page 76 example 1. 
Three dice are rolled, what is the probability of rolling atleast one 6?
"""

# Create a function which rolls a random number between 1 and 6, inclusive. 

function roller(number_of_dice)
    roll_outcome = []
    for f in 1:number_of_dice
        roll =  rand(1:6)
        push!(roll_outcome, roll) 
    end 
    return roll_outcome
end

outcome_tally = []

# Run a thousand rolls of three dice, and tally whether the 3 dice roll event contains atleast one
# six or not

for f in 1:1000
    event = roller(3)
    6 in event ? push!(outcome_tally, 1) : push!(outcome_tally, 0)
end

# Plot a basic histogram, and perform a basic sum of event with and without 6 

histrogram(outcome_tally)

length(filter(x -> x == 0, outcome_tally)) 

# It's confirmed here too! Of 1000 rolls, 587 don't contain a single six, and 483 contain at least one
# This translate to 0.587 and .483, respectively


"""
Page 78 example 2. 
Five chairs are arranged in a line, and five people randomly take seats. What is the probability that they end up in order of decreasing height, from left to right?
"""

# Create an ideal ordered set 

ordered_roll = [1,2,3,4,5]

# Randomly assign seats and compare events to the ideal event, if the event is the same as the ideal, add 1 to a tally, if not, add 0 

function bigToSmall(size_of_set, trial_size)
    outcome_tally = []
    ordered_set = reverse!(collect(1:size_of_set))
    for f in 1:trial_size
        event = shuffle(1:size_of_set)
        event == ordered_set ? push!(outcome_tally, 1) : push!(outcome_tally, 0)
    end 
    outcome_tally 
end

# By running the this trial x number of times, we can get the % of rolls which
# statisfy the condition, and determine if they match the expected probability or 1/120 = 0.0083

length(filter(x -> x == 1, outcome_tally))/length(outcome_tally)

# As this is a random sample, the actual probability may not match the theoreticaly probability, remember, this is over the expected probability after a large number of trials

# To see how the actual probability varies, we can repeat these trials n number of times, storing the probability after every trial --- the probability being the ratio of events which satsify the condition

simulation_counter = []

for f in 1:1000
    outcomes = bigToSmall(5, 100000)
    outcome_ratio =length(filter(x -> x == 1, outcomes))/length(outcomes)
    push!(simulation_counter, outcome_ratio)
end

mean(simulation_counter)
median(simulation_counter)
std(simulation_counter)
variance(simulation_counter) # which is std^2

# We can ask some fun questions using these measures

# Does the distribution of repeated event probabilities follow a certain function? E.g normal? 
# When varying the trial size e.g. 10, 50, 100, how often does an event not occur at all, occurs multiple times and so on?    
#


""" 
Page 80 Example 1 - Socks in a drawer
If there are 2 pairs of socks in a drawer, if you randomly draw two socks, what is the probability that you draw a pair?
"""

# Do repeated trials of two draws from 4 elements

pair_one = [1, 2]
pair_two = [3, 4]

# Anonymous function to pick two socks from a random permutation of four elements 
pick_two_socks = randperm(4)[1:2]

function pickingSocks(number_of_socks, trial_number)
    sock_pair_tally = []
    pair_one = [1, 2]
    pair_two = [3, 4]
    for f in 1:trial_number
        pick_two_socks = randperm(number_of_socks)[1:2]
        if issetequal(pick_two_socks, pair_one) || issetequal(pick_two_socks, pair_two)
            push!(sock_pair_tally, 1)
        else
        push!(sock_pair_tally, 0)
        end 
    end 
    return sock_pair_tally
end 

# Draw two socks from 4, one thousand times, and count whether they are pairs or not
sock_pair_tally = pickingSocks(4, 1000)

# In a dirty way, calculate what % of all drawers ended in a pair. 
# This should give us the 'long run' probability of drawing a pair of socks
length(filter(x -> x == 1, sock_pair_tally))/length(sock_pair_tally)

# 0.348, pretty darn close to the expected probability of 0.33 









