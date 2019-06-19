---
title: "Is this programing progress"
draft: false
description: Example of a C++17 complex code
---

- What are the qualities of the design bellow?
- Can this be done simpler in C, wihtout losing the design qualities?
- Can this be done using 

```cpp
// https://wandbox.org/permlink/udzltQne483qGrat
// compiled by dbj@dbj.org from popular C++17 youtube examples
#include <iostream>
#include <variant>
#include <vector>

// vararg inheritance and overloading of thus inherited

// 'Functor' is a type that has public function call operator
// arguments are vararg of Functor types
template<typename ... Functors>
// inherit from var num of Functor types passed as 
// template arguments above
struct Ovld : Functors ... {
   // have here function call operators from all the Functors inherited
   // derive a call operator from all functors
   using Functors::operator() ... ;
};
// user defined deduction guide

template<typename...Functors> Ovld(Functors...) /*seeing this ctor */
->  /* induce */
Ovld<Functors...> ; /* this as being it's type */

// we do not have to use the above mechanism
// but we are not sure design principles 
// behind are not superior
#define USE_OVERLORD
```
Funny enough we do not like polymorphism. So we have this C++17 mechanisms bellow, to achieve (with no hacks) polymorphism with no inheritance. By using `std::variant`.

```cpp

// https://youtu.be/e2ZQyYr0Oi0

struct Circle {
 void draw () { std::cout << "\n drawing Circle" ; }
};

struct Line {
 void draw () {  std::cout << "\n drawing Line"   ; }
};

using GeoObj = std::variant<Circle, Line> ;

inline void drawer ( std::vector<GeoObj> shapes )
{
    for ( auto && geoobj : shapes )
    {
#if ! defined(USE_OVERLORD)    
       std::visit( [] ( auto && obj ) { obj.draw(); }, geoobj ) ;
#else       
       std::visit(Ovld{
       // give two functors as two lambdas to the ctor of Ovld
       [] (Circle & c){ c.draw(); },
       [] (Line   & l){ l.draw(); }
       }, geoobj );
#endif
    }
}

int main()
{
    std::vector<GeoObj> shapes{ Circle{}, Line{} };
    drawer( shapes );
    std::cout << "\n\nDONE!" << std::endl;
}
```
`Ovld` is C++17 that seems very complex to majority of C++ programmers. And to **all** non C++ programmers.

But, it generates a hierarchical structure ot Types, and their instances, each of them programers would probably understand immediately.

![plantuml](https://www.plantuml.com/plantuml/img/RO_D2e9058NtzodEigW9Lor4Gj1b4FG65sV82wF6pAIBwjspoIIavVtE3_VaFh0BjyOI-OgjmJv9C8WEDL6GC8ApiHoaQtqjLm-5mhBtA8KlZXiYgk9zwgtEK8YhhDdYAAq13hWJiEaxqPEIfjhni5hF-6sSuVDRzZ7_f9U6sFzFfYcQFPHIyIcas85YO0afDwqUfxy0)

So, we have this C++17 features, working together that generate the simple type hierachy and overloads, but written in a very condensed code, hard to understand.

What are the prevailing benefits of the concepts on top of which `Ovld` is coded.
