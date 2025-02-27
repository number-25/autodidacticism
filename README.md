<img src="https://abfabrugcleaning.co.uk/wp-content/uploads/2015/06/Rug-Cleaning-Header-Default.jpg" height="" width="1200" align="center">

> *Education is our passport to the future, for tomorrow belongs to those who prepare for it today.*   
> -- <cite> Malcolm X </cite>


# Computational Biology for Autodidacts
A collection of resources that I have used (and hereby endorse) for those looking to teach themselves Computational Biology, as well as the branching disciplines which greatly influence comp. bio., such as Probability, Information Theory, Mathematics and so on. 

## Computational Biology and Bioinformatics
<details>
<summary> See full section </summary>

### Courses
#### Applied Computational Genomics at the University of Utah (2020/2021)
If you've had to do play around with .bam and .bed files than you've very likely come in contact with the excellent program called [Bedtools](https://bedtools.readthedocs.io/en/latest/index.html). Almost every time I need to use this program I discover something new about it, it just keeps on giving. The brain behind the Bedtools is [Aaron Quinlan](http://quinlanlab.org), a leading Computational Biologist out of the University of Utah . He offers a Semester long, **completely free** course which lives on [GitHub](https://github.com/quinlan-lab/applied-computational-genomics). Do you notice the trend here? World class thinkers who are willing to spread their knowledge, help others, and move Science forward, all without paywalls. Pay it forward if you ever get the chance! This is a great, in depth course which has many practical tutorials embedded within it. The homework is challenging and fulfilling - I have learned a lot here. Did I mention that Aaron is a terrific, down to earth teacher?

* Beginner/ entry level 
* Head over to [https://github.com/quinlan-lab/applied-computational-genomics](https://github.com/quinlan-lab/applied-computational-genomics)

#### Foundations of Computational and Systems Biology 
I can't be the only one who's jaw hits the floor when they see how rich MIT Open Course Ware has become, and how far back their content reaches in time. There are perhaps no better examples of the spirit of education than this initiative. Free lectures by some of the worlds top thinkers? You've gotta be kidding me. MIT Open Courserware was made for auto-didacts, there is little more you could ask for when seeking to educate yourself. Detailed course structures and trajectories, additional recommended readings, good quality videos, and no pay walls - yes!  

This course is run by a couple of great educators (Christopher Burge, David Gifford &amp; Ernest Fraenkel), who are also highly capable Scientists in their own right. For one, Chris Burge is one of the pioneers of *ab initio* gene prediction, a highly successful paradigm which allowed us to understand and annotate much of the early high throughput sequencing data. He is also centrally involved in the popular "Mixture of Isoforms" [(MISO)](https://sci-hub.st/10.1038/nmeth.1528) package. I recommend watching each lecture closely and definitely reading the accompanying writings. This is quite the intensive program if you decide to apply yourself, and it covers a sufficiently broad sweep of the field to give you the confidence to move forwards.  

* Late beginner/intermediate level
* [https://ocw.mit.edu/courses/biology/7-91j-foundations-of-computational-and-systems-biology-spring-2014/](https://ocw.mit.edu/courses/biology/7-91j-foundations-of-computational-and-systems-biology-spring-2014/) 

### Books
#### Biological Sequence Analysis: Probabilistic Models of Proteins and Nucleic Acids 
An oldie but a goody. Sean Eddy, Durbin et al., have all created phenomenal software that countless folks appreciate, the book stands on its own. Extensive and detailed, not to be taken lightly. 
Find more about here on Sean's [website](http://eddylab.org/cupbook.html). PDF copies may or may not be floating about * wink *. 

#### Algorithms on Strings, Trees, and Sequences 
Computer Science and Computational Biology by [Dan Gusfield](https://www.cambridge.org/core/books/algorithms-on-strings-trees-and-sequences/F0B095049C7E6EF5356F0A26686C20D3). Terrific detail, and since it was released eons ago, likely starts from a more ground level point of view. 

</details>

## Programming 

### Julia
<details> 
<summary> See full section on Julia </summary>

#### Courses and Workshops 

[Advanced Scientific Computing: Producing Better Code by Tim Holy](https://youtube.com/playlist?list=PL-G47MxHVTewUm5ywggLvmbUCNOD2RbKA&si=JyUkp6ItntQLnQXf)   
A terrific, short course on the use of Julia for scientific computing. Worth watching even for just the first lecture "Why Julia?" 

[Julia Advance](https://youtube.com/playlist?list=PLOU8LxhyFylKQO--4HIjX7_uzzVfRd5xu&si=4tsZ826J-FynYz8M). A more advanced YouTube playlist which deals with topics in Julia that are best approached once one has a decent feel for the language and can get around the ecosystem comfortably. 

[Julia for Data Science by Huda Nassar](https://youtube.com/playlist?list=PLP8iPy9hna6QuDTt11Xxonnfal91JhqjO&si=Vz_vOfZsUH9Y5MuA)   
Another terrific, medium level course specifically geared towards Data Science. Videos are of varying lengths and difficulties.   

[Julia Programming with a Data Scientist by Randy Davila](https://youtube.com/playlist?list=PLiUo37D6MN3GTDUk28NYIXqSl1hGVoni0&si=meBhZvubeXFE5EkZ)
A 6 part series which uses famous datasets such as Iris, to explore the data analytic workflows in Julia.

[Dr. Watson and Good Scientific Code Workshop](https://www.youtube.com/watch?v=x3swaMSCcYk) 
Dr. Watson is a clever workspace/code/project organiser which aims to standardise and simplify the way one initiates scientific projects in Julia. The documentation is extensive, and the 4 hour workshops covers both the technical purpose of the software, alongside the philosophy for why one ought to approach their projects in this manner. I found it compelling, and though I haven't started a project from the ground up using Julia, I have incorporated the ethos into my daily workflows. 

#### Books 

[Think Julia by Ben Lauwens and Allen B. Downey](https://github.com/BenLauwens/ThinkJulia.jl)   
Perhaps the best starting point for one interested in working through a text and progressively walking through topics. The book is a portover from the popular [Think Python by Allen B. Downey](https://allendowney.github.io/ThinkPython/). I learned a great deal from this one, and found a load of additional references which I am still pursuing, such as [Introduction to the Theory of Computation](), and the [Structure and Interpretation of Computer Programs]() . A phenomenal book. 

[Julia for Data Analysis by Bogumił Kamiński](https://www.manning.com/books/julia-for-data-analysis)
Bogumił  is the creator and maintainer of the powerful [DataFrames.jl
package](https://dataframes.juliadata.org/stable/). He is a frequent
contributer to StackExchange and the the official Julia forum. If you've got a
weird question, Bogumił has likely given the answer to it somewhere.. His short
blog posts are also very helpful. 

[Statistics with Julia by Yoni Nazarathy and Hayden Klok](https://statisticswithjulia.org/)   
An ideal reference text for approaching Statistics in Julia. Julia itself has a
noteworthy number of statistics modules built into it's Base feature set, so
you'd be surprised how far you can do on the bare bones. The source for the
book is [open](https://github.com/h-Klok/StatsWithJuliaBook), and there are a
handful of [tutorials](https://statisticswithjulia.org/tutorials/) on the books
site. Yoni still works at the University of Queensland where I completed my
post-graduate studies, I'm still regretful that I never got a chance to meet
with him.   

#### Blog Posts
* [Best practise: organising code in Julia](https://discourse.julialang.org/t/best-practise-organising-code-in-julia/74362/2) - really terrific guide, worth much!

To be continued... 

</details> 

### R
<details> 
<summary> See full section on R </summary> 

#### Courses
[Data Science: Foundations using R on Coursera](https://www.coursera.org/specializations/data-science-foundations-r)   
If you're in the genomics-bioinformatics space, the name Jeff Leek is likely
familiar, and probably that of Roger Peng also. Both are excellent educators and
forthright scientists. I learned a whole lot from [Jeff Leek's guide to
genomics papers](https://github.com/jtleek/genomicspapers). An appreciation of
the sources of variability and noise in genomics data was a yuuge take away
from the papers, so I was glad to find this R course. It provides a easy to
medium level entrypoint to R, often times using genomics data as examples.
At the same time as I was learning R, I decided to primarily use Julia to work through the weekly problem sets, giving myself an additional opportunity to learn more of the latter language.   

#### Books 
[R for Data Science by Hadley Wickham, Mine Cetinkaya-Rundel, and Garrett Grolemund](https://r4ds.hadley.nz/)   
A classic at this point - completely free online, need more be said? 

</details> 

### Nextflow and nf-core 
<details> 
<summary> See full section on nextflow </summary> 

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
#### Books
##### Intuitive Biostatistics: A Nonmathematical Guide to Statistical Thinking
I believe this is the most comfortable introduction to conceptualising problems, and answers, in a more quantitative manner. As the title outlines, this book is almost purely built on intuitive explanations of key, widely used procedures in statistics. It explains what x is, when you would do x, why you would do it, why you wouldn't, and more appropriately, the assumptions and biases associated with x. If you're afraid of equations (overcome this fear as soon as possible, there is nothing to fear), you'll be given that first bit of confidence that should then give you the enthusiasm and energy to continue developing. The language here is very clear, very direct, very concise and to the point. The text is very honest, and works hard to provide bountiful examples of both good and bad uses of statistics in the literature. You will enjoy working through it, trust! The author Harvey Motulsky is the founder of [GraphPad](https://www.graphpad.com/company/) Statistical Analysis software, so you may have already come across his creations without knowing! There is also a smaller streamlined text from Harvey called "Essential Biostatistics", which is also worth reading if you just need a straight forward and reduced explanation. One last note, this book leans heavily towards biomedical research, and so most of the examples pull directly from this field. Strongly recommended. 

* PERFECT for absolute beginners. Great reference to have on hand for those more familiar. 
* I must admit, the book is not cheap, and the smaller "Essential" book is just not worth buying - it is an anorexic ~150 pages of widely spaced formatting. I used library copies for both until I had enough savings to purchase the larger of the two books. If you prefer eBooks than I'd go looking.

### Probability theory 

[Reasoning About Luck: Probability and its Uses in Physics](https://www.cambridge.org/core/books/reasoning-about-luck/10C483B28237DF9B870E841794DB9541)

[MIT Introductionn to
Probability](https://ocw.mit.edu/courses/res-6-012-introduction-to-probability-spring-2018/)
alongside the prescribed text [Introduction to Probability by  Dimitri P.
Bertsekas and John N. Tsitsiklis](http://athenasc.com/probbook.html), with
[YouTube
lectures](https://youtube.com/playlist?list=PLUl4u3cNGP60hI9ATjSFgLZpbNJ7myAg6&si=u95oAqTauX9_uneH)   

[Probability: For the Enthusiastic Beginner](https://davidmorin.physics.fas.harvard.edu/books/probability/)   

### Mathematics 

[Combinatorics Through Guided Discovery by Kenneth P. Bogart](https://bogart.openmathbooks.org/)

[No Bullshit Guide to Math and Physics by Ivan Savov](https://bogart.openmathbooks.org/)

Mathematics for Nonmathematicians by Morris Kline
The great Kline. 

[Art of Problem Solving Vol 1. by Sandor Lehoczky and Richard Rusczyk](https://artofproblemsolving.com/store/book/aops-vol1)

</details>
