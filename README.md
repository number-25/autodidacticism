<img src="https://abfabrugcleaning.co.uk/wp-content/uploads/2015/06/Rug-Cleaning-Header-Default.jpg" height="" width="1200" align="center">



# Computational Biology for Autodidacts
A collection of resources that I have used (and hereby endorse) for those looking to teach themselves Computational Biology, as well as the branching disciplines which greatly influence comp. bio., such as Probability, Information Theory, Mathematics and so on. 

I will also include a separate list of resources that I have come across and been recommended, but have not used - as such, these will not be my endorsements, but simply references for you to explore further if you wish.

### Computational Biology and Bioinformatics
<details>
<summary> See full section </summary>

#### Courses 
#### Applied Computational Genomics at the University of Utah (2020/2021)
If you've had to do play around with .bam and .bed files than you've very likely come in contact with the excellent program called [Bedtools](https://bedtools.readthedocs.io/en/latest/index.html). Almost every time I need to use this program I discover something new about it, it just keeps on giving. The brain behind the Bedtools is [Aaron Quinlan](http://quinlanlab.org), a leading Computational Biologist out of the University of Utah . He offers a Semester long, **completely free** course which lives on [GitHub](https://github.com/quinlan-lab/applied-computational-genomics). Do you notice the trend here? World class thinkers who are willing to spread their knowledge, help others, and move Science forward, all without paywalls. Pay it forward if you ever get the chance! This is a great, in depth course which has many practical tutorials embedded within it. The homework is challenging and fulfilling - I have learned a lot here. Did I mention that Aaron is a terrific, down to earth teacher?

* Beginner/ entry level 
* Head over to [https://github.com/quinlan-lab/applied-computational-genomics](https://github.com/quinlan-lab/applied-computational-genomics)

#### Foundations of Computational and Systems Biology 
I can't be the only one who's jaw hits the floor when they see how rich MIT Open Course Ware has become, and how far back their content reaches in time. There are perhaps no better examples of the spirit of education than this initiative. Free lectures by some of the worlds top thinkers? You've gotta be kidding me. MIT Open Courserware was made for auto-didacts, there is little more you could ask for when seeking to educate yourself. Detailed course structures and trajectories, additional recommended readings, good quality videos, and no pay walls - yes!  

This course is run by a couple of great educators (Christopher Burge, David Gifford &amp; Ernest Fraenkel), who are also highly capable Scientists in their own right. For one, Chris Burge is one of the pioneers of *ab initio* gene prediction, a highly successful paradigm which allowed us to understand and annotate much of the early high throughput sequencing data. He is also centrally involved in the popular "Mixture of Isoforms" [(MISO)](https://sci-hub.st/10.1038/nmeth.1528) package. I recommend watching each lecture closely and definitely reading the accompanying writings. This is quite the intensive program if you decide to apply yourself, and it covers a sufficiently broad sweep of the field to give you the confidence to move forwards.  

* Late beginner/intermediate level
* [https://ocw.mit.edu/courses/biology/7-91j-foundations-of-computational-and-systems-biology-spring-2014/](https://ocw.mit.edu/courses/biology/7-91j-foundations-of-computational-and-systems-biology-spring-2014/) 

#### Books
#### Biological Sequence Analysis: Probabilistic Models of Proteins and Nucleic Acids 
An oldie but a goody. Sean Eddy, Durbin et al., have all created phenomenal software that countless folks appreciate, the book stands on its own. Extensive and detailed, not to be taken lightly. 
Find more about here on Sean's [website](http://eddylab.org/cupbook.html). PDF copies may or may not be floating about * wink *. 

</details>

## Programming 
<details> 
<summary> See full section </section>

### Julia
#### Courses and Workshops 

[Advanced Scientific Computing: Producing Better Code by Tim Holy](https://youtube.com/playlist?list=PL-G47MxHVTewUm5ywggLvmbUCNOD2RbKA&si=JyUkp6ItntQLnQXf)   
A terrific, short course on the use of Julia for scientific computing. Worth watching even for just the first lecture "Why Julia?" 

[Julia Advance](https://youtube.com/playlist?list=PLOU8LxhyFylKQO--4HIjX7_uzzVfRd5xu&si=4tsZ826J-FynYz8M). A more advanced YouTube playlist which deals with topics in Julia that are best approached once one has a decent feel for the language and can get around the ecosystem comfortably. 

[Julia for Data Science by Huda Nassar](https://youtube.com/playlist?list=PLP8iPy9hna6QuDTt11Xxonnfal91JhqjO&si=Vz_vOfZsUH9Y5MuA)   
Another terrific, medium level course specifically geared towards Data Science. Videos are of varying lengths and difficulties.   



#### Books 
[Think Julia by Ben Lauwens and Allen B. Downey](https://github.com/BenLauwens/ThinkJulia.jl)   
Perhaps the best starting point for one interested in working through a text and progressively walking through topics. The book is a portover from the popular [Think Python by Allen B. Downey](https://allendowney.github.io/ThinkPython/). I learned a great deal from this one, and found a load of additional references which I am still pursuing, such as [Introduction to the Theory of Computation](), and the [Structure and Interpretation of Computer Programs]() . A phenomenal book. 

[Julia for Data Analysis by Bogumił Kamiński](https://www.manning.com/books/julia-for-data-analysis)
Bogumił  is the creator and maintainer of the powerful [DataFrames.jl
package](https://dataframes.juliadata.org/stable/). He is a frequent
contributer to StackExchange and the the official Julia forum. If you've got a
weird question, Bogumił has likely given the answer to it somewhere.. His short
blog posts are also very helpful. 

Julia for Data Scientists 
Dr. Watson 

### R
### Courses
I took this course and ported much of it into Julia. 


### Nextflow and nf-core 

I must admit, the documentation for Nextflow and nf-core has always felt
slightly scattered to me, with overlapping and counter-intuitive "Tutorials,
Guides, Examples, Best practices" sections across their web footprint. 

The roadmap that I eventually narrowed down 




</details>


## Mathematics, Probability, and Statistics
<details>
<summary> See full section </summary>

Coming from Biology, a field closely wedded to the qualitative aspects of Scientific inference, where our formal training for the most part omits many of the approaches utilised by the 'harder sciences', the transition to the quantitative world has perhaps been the most challenging part of this. In some respects, you must undergo a great change in how you approach problems, how you approach data and measures, and your relationship to truth and validity. Much of this can be uncomfortable, as you must confront the fragility of your prior approaches to questions. Personally, this is an ongoing project which demands a lot of effort and grit. I have immensely appreciated this change in my thought processes, and am very grateful that it has taken place. The world is a bigger place now than it ever was. A world where precision, consistency, and repetition are emphasised. You will likely develop an obsession with priors, and with starting assumptions. Sometimes before we can even approach a problem, we must sketch out some vague axioms we believe to be important. Unfortunately, these topics are taught in notoriously bland ways across campuses alike - they are premature, are forced, and very often, the student barely has any confidence in their own logic and reasoning. Such courses may at times skip over the very basic reason for using tools such as probability theory in the first place; to make *better* decisions in the presence of uncertainty.

### Statistics
### Books
#### Intuitive Biostatistics: A Nonmathematical Guide to Statistical Thinking
I believe this is the most comfortable introduction to conceptualising problems, and answers, in a more quantitative manner. As the title outlines, this book is almost purely built on intuitive explanations of key, widely used procedures in statistics. It explains what x is, when you would do x, why you would do it, why you wouldn't, and more appropriately, the assumptions and biases associated with x. If you're afraid of equations (overcome this fear as soon as possible, there is nothing to fear), you'll be given that first bit of confidence that should then give you the enthusiasm and energy to continue developing. The language here is very clear, very direct, very concise and to the point. The text is very honest, and works hard to provide bountiful examples of both good and bad uses of statistics in the literature. You will enjoy working through it, trust! The author Harvey Motulsky is the founder of [GraphPad](https://www.graphpad.com/company/) Statistical Analysis software, so you may have already come across his creations without knowing! There is also a smaller streamlined text from Harvey called "Essential Biostatistics", which is also worth reading if you just need a straight forward and reduced explanation. One last note, this book leans heavily towards biomedical research, and so most of the examples pull directly from this field. Strongly recommended. 

* PERFECT for absolute beginners. Great reference to have on hand for those more familiar. 
* I must admit, the book is not cheap, and the smaller "Essential" book is just not worth buying - it is an anorexic ~150 pages of widely spaced formatting. I used library copies for both until I had enough savings to purchase the larger of the two books. If you prefer eBooks than I'd go looking.

Probability theory 

Reasoning about luck: Probability and its uses in physics 

MIT prob theory? 

Probability theory for the enthusiastic beginner 

# Math 
Combinatorics Through Guided Discovery 

No bullshit guide to math and physics 

Mathematics for the Nonmathematicians 
Art of Problem Solving Vol 1. 




</details>
