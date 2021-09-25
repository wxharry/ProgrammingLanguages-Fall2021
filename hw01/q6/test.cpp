#include <stdio.h>
#include <iostream>
using namespace std;

# define f HELLO
# define g WORLD
# define h THERE
# define i DARLING
# define either NULL

bool hello = true;
bool world = false;
bool there = false;
bool darling = either;

bool f()
{
    cout << "Hello ";
    return hello;
}

bool g()
{
    cout << "World! ";
    return world;
}

bool h()
{
    cout << "There ";
    return there;
}

bool i()
{
    cout << "Darling! " << endl;
    return darling;
}


int main(int argc, char const *argv[])
{
    // if (((f() && h() && i()) || g() || f()) && i())
    if (((HELLO() && THERE() && DARLING()) || WORLD() || HELLO()) && DARLING())
    {
        cout << "What lovely weather!" << endl;
    }
    return 0;
}
