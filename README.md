# Alan Turing (1912-1954)

This is the collection of links and papers where you can learn more about Alan Turing, his life and his contributions to today's technology.

![image](https://image.shutterstock.com/image-illustration/bogor-indonesia-march-09-2021-600w-1932471755.jpg)

[Alan Mathison Turing](https://en.wikipedia.org/wiki/Alan_Turing) (23 June 1912 - 7 June 1954) was one of the pioneers in today's technology. He had some key contributions in breaking the [Enigma machine](https://en.wikipedia.org/wiki/Enigma_machine) during the World War II, which had a huge impact on the result of World War II. He also [pioneered the work in Artificial Intelligence](http://m.bbc.com/news/technology-18475646) (even before the term Artificial Intelligence was established), where he was the first one to discuss the ways of replicating human brain inside of a machine. His papers remain relevant today in this field, 60 years after they were published. [Turing test](https://en.wikipedia.org/wiki/Turing_test) (a test which is used to determine is a machine intelligence really indistinguishable from human intelligence) was named after him.

## Biography

A short [biography of Alan Turing](http://www.turing.org.uk/bio/index.html) is written by Andrew Hodges.

# State Machines

![image](https://cdn-media-1.freecodecamp.org/images/0*3QzqRMfRCh28-xe1.)

## Finite State Machines

A finite state machine is a mathematical abstraction used to design algorithms.

In simpler terms, a state machine will read a series of inputs. When it reads an input, it will switch to a different state. Each state specifies which state to switch to, for a given input. This sounds complicated but it is really quite simple.

Imagine a device that reads a long piece of paper. For every inch of paper there is a single letter printed on it–either the letter ‘a’ or the letter ‘b’.

As the state machine reads each letter, it changes state. Here is a very simple state machine:

## Deterministic Finite State Machines

The state machines we’ve looked at so far are all deterministic state machines. From any state, there is only one transition for any allowed input. In other words, there can’t be two paths leading out of a state when you read the letter ‘a’. At first, this sounds silly to even make this distinction.

What good is a set of decisions if the same input can result in moving to more than one state? You can’t tell a computer, if x == true then execute doSomethingBig or execute doSomethingSmall, can you?

Well, you kind of can with a state machine.

The output of a state machine is its final state. It goes through all its processing, and then the final state is read, and then an action is taken. A state machine doesn’t do anything as it moves from state to state.

It processes, and when it gets to the end, the state is read and something external triggers the desired action (for example, dispensing a soda can). This is an important concept when it comes to non-deterministic finite state machines.

Non-deterministic Finite State Machines
Non-deterministic finite state machines are finite state machines where a given input from a particular state can lead to more than one different state.

For example, let’s say we want to build a finite state machine that can recognize strings of letters that:

Start with the letter ‘a’
and are then followed by zero or more occurrences of the letter ‘b’
or, zero or more occurrences of the letter ‘c’
are terminated by the next letter of the alphabet.
Valid strings would be:

abbbbbbbbbc
abbbc
acccd
acccccd
ac (zero occurrences of b)
ad (zero occurrences of c)
So it will recognize the letter ‘a’ followed by zero or more of the same letter of ‘b’ or ‘c’, followed by the next letter of the alphabet.

A very simple way to represent this is with a state machine that looks like the one below, where a final state of t means that the string was accepted and matches the pattern.

## Regular Expressions

If you have done any type of programming, you’ve probably encountered regular expressions. Regular expressions and finite state machines are functionally equivalent. Anything you can accept or match with a regular expression, can be accepted or matched with a state machine.

For example, the pattern described above could be matched with the regular expression: a(b*c|c*d)

Regular expressions and finite state machines also have the same limitations. In particular, they both can only match or accept patterns that can be handled with finite memory.

So what type of patterns can’t they match? Let’s say you want to only match strings of ‘a’ and ‘b’, where there are a number of ‘a’s followed by an equal number of ‘b’s. Or n ‘a’s followed by n ‘b’s, where n is some number.

Examples would be:

ab
aabb
aaaaaabbbbbb
aaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbb
At first, this looks like an easy job for a finite state machine. The problem is that you’ll quickly run out of states, or you’ll have to assume an infinite number of states — at which point it is no longer a finite state machine.

Let’s say you create a finite state machine that can accept up to 20 ‘a’s followed by 20 ‘b’s. That works fine, until you get a string of 21 ‘a’s followed by 21 ‘b’s — at which point you will need to rewrite your machine to handle a longer string.

For any string you can recognize, there is one just a little bit longer that your machine can’t recognize because it runs out of memory.

This is known as the Pumping Lemma which basically says: “if your pattern has a section that can be repeated (like the one) above, then the pattern is not regular”.

In other words, neither a regular expression nor a finite state machine can be constructed that will recognize all the strings that do match the pattern.

If you look carefully, you’ll notice that this type of pattern where every ‘a’ has a matching ‘b’, looks very similar to HTML. Within any pair of tags, you may have any number of other matching pairs of tags.

So, while you may be able to use a regular expression or finite state machine to recognize if a page of HTML has the <html>, <head>; and <body> elements in the correct order, you can’t use a regular expression to tell if an entire HTML page is valid or not — because HTML is not a regular pattern.

# Turing Machines

So how do you recognize non-regular patterns?

There is a theoretical device that is similar to a state machine, called a Turing Machine. It is similar to a finite state machine in that it has a paper strip which it reads. But, a Turing Machine can erase and write on the paper tape.

Explaining a Turing Machine will take more space that we have here, but there are a few important points relevant to our discussion of finite state machines and regular expressions.

Turing Machines are computationally complete — meaning anything that can be computed, can be computed on a Turing Machine.

Since a Turing Machine can write as well as read from the paper tape, it is not limited to a finite number of states. The paper tape can be assumed to be infinite in length. Of course, actual computers don’t have an infinite amount of memory. But, they usually do contain enough memory so you don’t hit the limit for the type of problems they process.

Turing Machines give us an imaginary mechanical device that lets us visualize and understand how the computational process works. It is particularly useful in understanding the limits of computation. If there is interest I’ll do another article on Turing Machines in the future.

Let assume all user events are aaaabbbbbccccc and exceptra

Construct a TM for the language L = {0n^1n^2n} where n≥1

### and here 0 1 2 are events on application

L = {0n1n2n | n≥1} represents language where we use only 3 character, i.e., 0, 1 and 2. In this, some number of 0's followed by an equal number of 1's and then followed by an equal number of 2's. Any type of string which falls in this category will be accepted by this language.

The simulation for 001122 can be shown as below:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm.png)

Now, we will see how this Turing machine will work for 001122. Initially, state is q0 and head points to 0 as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm2.png)
The move will be δ(q0, 0) = δ(q1, A, R) which means it will go to state q1, replaced 0 by A and head will move to the right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm3.png)
The move will be δ(q1, 0) = δ(q1, 0, R) which means it will not change any symbol, remain in the same state and move to the right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm4.png)
The move will be δ(q1, 1) = δ(q2, B, R) which means it will go to state q2, replaced 1 by B and head will move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm5.png)
The move will be δ(q2, 1) = δ(q2, 1, R) which means it will not change any symbol, remain in the same state and move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm6.png)
The move will be δ(q2, 2) = δ(q3, C, R) which means it will go to state q3, replaced 2 by C and head will move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm7.png)
Now move δ(q3, 2) = δ(q3, 2, L) and δ(q3, C) = δ(q3, C, L) and δ(q3, 1) = δ(q3, 1, L) and δ(q3, B) = δ(q3, B, L) and δ(q3, 0) = δ(q3, 0, L), and then move δ(q3, A) = δ(q0, A, R), it means will go to state q0, replaced A by A and head will move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm8.png)
The move will be δ(q0, 0) = δ(q1, A, R) which means it will go to state q1, replaced 0 by A, and head will move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm9.png)
The move will be δ(q1, B) = δ(q1, B, R) which means it will not change any symbol, remain in the same state and move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm10.png)
The move will be δ(q1, 1) = δ(q2, B, R) which means it will go to state q2, replaced 1 by B and head will move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm11.png)
The move will be δ(q2, C) = δ(q2, C, R) which means it will not change any symbol, remain in the same state and move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm12.png)
The move will be δ(q2, 2) = δ(q3, C, L) which means it will go to state q3, replaced 2 by C and head will move to left until we reached A as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm13.png)
immediately before B is A that means all the 0's are market by A. So we will move right to ensure that no 1 or 2 is present. The move will be δ(q2, B) = (q4, B, R) which means it will go to state q4, will not change any symbol, and move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm14.png)
The move will be (q4, B) = δ(q4, B, R) and (q4, C) = δ(q4, C, R) which means it will not change any symbol, remain in the same state and move to right as:
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm15.png)
The move δ(q4, X) = (q5, X, R) which means it will go to state q5 which is the HALT state and HALT state is always an accept state for any TM.
![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm16.png)

## And here we get the acceptable state

![image](https://static.javatpoint.com/tutorial/automata/images/automata-examples-of-tm17.png)

### think about this is the appliacation flows for user
