<img src="https://res.akamaized.net/domain/image/fetch/c_fill,h_630,w_1200/https://static.domain.com.au/cre/production/2016/12/nationallibraryczechrepublic.jpg" height="350" width="900" align="center">




# Computational Biology for Autodidacts
A collection of resources that I have used (and hereby endorse) for those looking to teach themselves Computational Biology, as well as the branching disciplines which greatly influence comp. bio., such as Probability, Information Theory, Mathematics and so on. 

I will also include a separate list of resources that I have come across and been recommended, but have not used - as such, these will not be my endorsements, but simply references for you to explore further if you wish.


The main home of this webpage is over at my website ["Kobe and Pascal"](https://kobeandpascal.com/computational-biology-for-autodidacts/)

## Books and eBooks

### Unix-Linux
#### Unix Workbench
The fundamental starting point in computational biology is the terminal window. It may terrify you at first, but please persist, and move forward with excitement as you begin traversing your system in a completely new way. Believe me, right now things may seem so rosy and magical as you whiz around in your general user interface (GUI), coddled by the ease of point and click, but with enough time, you will begin dreading the clunkiness of some GUI programs. The majority of tools in computational biology are built around a unix/linux system, and as such these are generally the very basic requirements. Embarking on a journey of learning unix based systems, in my opinion, comes with committing to a philosophy of open software and freedom of access to information. This is fundamentally about love. Love of education, love of knowledge, love of others, and a love of those that come after us. It is not surprising that almost every resource I have come across has offered a free version alongside paid options. 

You will begin seeing how fundamental and necessesary these programs are for the proper functioning of modern day Scientific research. Hopefully you will appreciate how beautifully efficient they are, and the elegance of simple bash programs who aim to do one thing right.

You likely want to begin here, and take yourself so far, probably stopping right before you reach the vim vs. emacs wars. After you’re proficient in simple processes, then you can spend your precious time pondering whether org-mode is worth trying.

* The [Unix Workbench](https://seankross.com/the-unix-workbench/) by Sean Kross. 
* https://github.com/seankross/the-unix-workbench 
* Sean also kindly provides a Coursera unit which follows the structure of the book - highly recommended.

#### Learn Enough Command Line to Be Dangerous
This is a companion resource to Unix Workbench, it begins at the same skill level (beginner), and like Unix Workbench, works through the essentials, with a focus on pragmatism. Having a go at the exercises is worth while, and creating a personal cheat sheet of sorts is also not a bad idea. Straight forward, stimulating and very helpful for the beginner. 

* [Learn Enough Command Line to Be Dangerous](https://www.learnenough.com/command-line-tutorial/basics) by [Michael Hartl](https://www.michaelhartl.com/).
* Free online.

### Specific Computational Biology Texts
#### Biostars Handbook

One of the most empowering developments to come out of bioinformatics/computational biology education is [Biostars](https://www.biostars.org/). I would put my money on it that the word "Biostars" is familiar to every single student in this field. The legendary forum for finding answers to what seems to be, every practical question you could think of. [Istvan Albert](https://github.com/ialbert) and his colleagues have gone ahead and condensed their understanding into the Biostar Handbook, which, at a very reasonable price (especially when it comes to textbooks) brings you up to speed, and in my opinion, gets you very close to being competent and independent. What I love most about this book is its brutal honesty, its transparency and its emphasis of diligence and patience. They have slowly started breaking the book up into more specific and parcelized mini-books that focus on a particular topic. Another big benefit of this is that Istvan generously provides full access to his University lectures, which are also terrific.  

* Most recommended for beginners/entry level
* [https://www.biostarhandbook.com/](https://www.biostarhandbook.com)

#### Computational Biology: A HyperTextbook

In searching for a beginner level computational biology text that was up to date with more recent developments in the field, I found it surprisingly difficult to track anything down that was released less than 5 years ago. Either the text's were focused on a specific section of comp. bio., such as sequence matching algorithms, or they were highly recommended relics released at the advent of high throughput sequencing - classics indeed, but insufficient for a wholesome entry into the current field. Scrolling through twitter I saw a recommendation for Scott Kelly's and Denis Didulo's "Computational Biology: A Hypertextbook" - it seemed to tick all the boxes. Despite the lack of reviews and anecdotes, I took the chance and purchased the e-book. Given it's main selling point is that it is a Hypertext-book, I figured using the print form would be too clunky. So far I am very happy with the purchase - it is generalised enough for a beginner, yet still specific in ways that Biostars isn't. For example it has chapters on essentials such as how exactly the Smith-Waterman algorithm functions and so on. An excellent reference text which deserves more attention! My biggest hunch here is not with the textbook exactly, but rather with the ebook medium which it uses - a service called VitalSource, a underpowered platform which allows you to purchase books on how to use linux, only to then realise that their standalone offline apps do not come with Linux compatibility!! How you would open the book on Linux if you lacked internet connection is a mystery to me. Either way - the book is great. 

* Recommended for beginners/entry level 
* [https://www.amazon.com.au/Computational-Biology-Hypertextbook-Scott-Kelley/dp/1683670027](https://www.amazon.com.au/Computational-Biology-Hypertextbook-Scott-Kelley/dp/1683670027)
* [Kelley](http://www.bio.sdsu.edu/faculty/kelley/scottkelley.html) lab

## Courses 

#### Foundations of Computational and Systems Biology 
I can't be the only one who's jaw hits the floor when they see how rich MIT Open Course Ware has become, and how far back their content reaches in time. There are perhaps no better examples of the spirit of education than this initiative. Free lectures by some of the worlds top thinkers? You've gotta be kidding me. MIT Open Courserware was made for auto-didacts, there is little more you could ask for when seeking to educate yourself. Detailed course structures and trajectories, additional recommended readings, good quality videos, and no pay walls - yes!  

This course is run by a couple of great educators (Christopher Burge, David Gifford &amp; Ernest Fraenkel), who are also highly capable Scientists in their own right. For one, Chris Burge is one of the pioneers of *ab initio* gene prediction, a highly successful paradigm which allowed us to understand and annotate much of the early high throughput sequencing data. He is also centrally involved in the popular "Mixture of Isoforms" [(MISO)](https://sci-hub.st/10.1038/nmeth.1528) package. I recommend watching each lecture closely and definitely reading the accompanying writings. This is quite the intensive program if you decide to apply yourself, and it covers a sufficiently broad sweep of the field to give you the confidence to move forwards.  

* Late beginner/intermediate level
* [https://ocw.mit.edu/courses/biology/7-91j-foundations-of-computational-and-systems-biology-spring-2014/](https://ocw.mit.edu/courses/biology/7-91j-foundations-of-computational-and-systems-biology-spring-2014/) 

#### Applied Computational Genomics at the University of Utah (2020/2021)
If you've had to do play around with .bam and .bed files than you've very likely come in contact with the excellent program called [Bedtools](https://bedtools.readthedocs.io/en/latest/index.html). Almost every time I need to use this program I discover something new about it, it just keeps on giving. The brain behind the Bedtools is [Aaron Quinlan](http://quinlanlab.org), a leading Computational Biologist out of the University of Utah . He offers a Semester long, **completely free** course which lives on [GitHub](https://github.com/quinlan-lab/applied-computational-genomics). Do you notice the trend here? World class thinkers who are willing to spread their knowledge, help others, and move Science forward, all without paywalls. Pay it forward if you ever get the chance! This is a great, in depth course which has many practical tutorials embedded within it. The homework is challenging and fulfilling - I have learned a lot here. Did I mention that Aaron is a terrific, down to earth teacher?

* Beginner/ entry level 
* Head over to [https://github.com/quinlan-lab/applied-computational-genomics](https://github.com/quinlan-lab/applied-computational-genomics)
