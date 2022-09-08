Articles and Sample code for creating a layered, object-oriented persistence framework.

The two .ZIP archives accompanying this file were originally posted to the borland.public.attachments forum by Philip Brown on 19 Dec 2000, and the following notice appeared in the borland.public.delphi.oodesign forum:

===
begin quote
===
For those interested, I have posted my EXE articles and a *very simple*
framework example in attachments. The framework was designed for tuition
purposes, not for real world usage, but the essence is there.

Please note that due to time constraints I cannot support or enter into
discussions about the code.

--
Philip Brown
Informatica Systems Ltd
===
end quote
===

The archives have been re-posted here with Philip's permission. In light of Philip's request, questions or discussion points should be posted generally to the borland.public.delphi.oodesign forum.

Contents of "Simple Framework.ZIP" copyright Informatica Systems Ltd, 1999.

Contents of "EXE Articles.ZIP," including extracted paragraphs below, copyright Philip Brown 2000.


Index of EXE Articles.ZIP: 

200002.doc
Standardising Application Builds
Philip Brown introduces his column and describes how to ensure your applications are compiled correctly.
Welcome to my first column for EXE magazine. Hopefully I'll be able to make it an interesting and stimulating series, exploring many facets of Delphi development. Firstly, let me introduce myself. I'm an IT consultant and active programmer for nearly two decades, just in time to catch the demise of the punched card and herald the advent of relatively accessible and cheap computing power. Over these years I have used many languages and it is my belief that Delphi is the best general-purpose Windows development tool currently available, with an excellent blend of powerful constructs, user interface tools and support for strong object-oriented development techniques.


200003.doc
Adding Version Information To Applications
Last month I discussed the concept of a build, and why a standard process to produce a consistent set of deliverables was a good thing. This month we will investigate the means by which version information can be made available within an application, writing a class which can be incorporated into any new development.


200004.doc
Implementing Business Objects
Classes that encapsulate business rules lay the foundations of a true object oriented application.
This month's column is the first of a series in which we'll be exploring the many facets of implementing a true object oriented application. Along the way we'll take in almost every aspect of application design and challenge some of the accepted ways of writing a Delphi application. The fundamental concept behind this approach is encapsulation: to design a set of classes with well-defined interfaces (methods) that operate on properties. These concepts will pervade the entire application and will greatly affect the way in which data is stored and presented. I would recommended readers to study Francis Glassborow's C++ column; although the Delphi object model lacks the completeness (and the complexity) of C++, the concepts of good class design are independent of language.

200005.doc
Simple Object Relationships
Business objects like to expose themselves and their relations. This month Philip Brown shows you how.
Last month we looked at how the classic Stock, Order and Customer requirement could be modelled as three separate business objects, each exposing their state through well-defined properties. Although these objects could now be used as-is (although in a very limited way - we haven't yet defined how to make their information persistent!), they lack any concept of relationships. In other words, how do we know which Customer placed a given Order, and for which StockItem?

200006.doc
Persistent Objects
Object data must ultimately be stored in a database. Philip Brown shows you how.
In the last couple of months we have introduced business objects and shown how simple relationships can be represented. The relationships expressed as object properties are a more formal (and neutral) representation of the relationships between data entities that can be implicit within the database design, or explicit within the database schema. Moving away from a data-centric view of entities and relationships to a more structured, object-oriented exposition has many benefits, but most languages (including Delphi) cater only for an in-memory object model; objects have no state persistence capability unless one is provided for them.

200007.doc
Are You Being Served?
This month Philip Brown presses the Factory pattern into service for menu operations.
This month we take a short break from the rigours of implementing business objects to deal with something that almost every application requires: a menu. Not a menu in the sense of a TMainMenu derivative, but rather some sort of front-end which shows a number of available options and requires one to be selected by the user. A typical example would be a list of options presented to the user when an application starts: they are required to select whether to launch the main application, or maybe the reporting package, general utilities or admin systems. These options are typically presented to the user in fairly crude ways, maybe a small form with a number of buttons each with a caption describing the application to be run, or a list box with a number of entries. Most often these menu-type forms are hard coded and intrinsically "know" how to launch the selected option. Such solutions share two properties: they're inflexible and unattractive. This month we use the Factory pattern (and judicious choice of visual component) to provide a better solution.

200008.doc
The Needs Of The Many
This month Philip Brown demonstrates one way of working with sets of business objects 
This month we return to the world of a general purpose object framework and complete relationship handling by considering how to work with sets or collections of business objects. So far we have seen how to express simple 1-1 or many-1 relationships by simply exposing the related object as a property, such as Order.Customer. This is a simple and natural way to expose related objects, with the appropriate handling occurring within the accessor functions of the property, but how can we expose the other variants of relationships, namely 1-many or many-many? A simple approach, such as Customer.Order, does not serve our purpose as it implies that there is a single Order for a given Customer (which is generally not the case), and prevents access to any other Orders that might exist. What we need is syntax, and an efficient implementation, for handling a set of business objects.

200009.doc
Concise Custom Constructors
This month Philip Brown continues his look at implementing sets of objects
Last month I set out the broad principles behind implementing sets of objects with a problem domain oriented class to act as a container for the business objects themselves. This relied upon an extended data management class that could support navigation through a database-dependent cursor of some kind. This month concludes this investigation by providing some more implementation details and we see that once the application independent framework has been provided, the actual code required for a real system is very small.
