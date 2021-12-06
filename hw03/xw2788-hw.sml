(* helper functions *)
fun append [ ] ys = ys
  | append (x::xs) ys = x :: (append xs ys);

fun reverse [] = []
  | reverse (x::xs) =  (reverse xs)@[x];

(* reverse [1,2,3,4,5]; *)

(* 4.1 *)
fun alternate [] = 0
  | alternate (x::xs) = x - alternate xs;

alternate [1,2,3,4];


(* 4.2 *)
fun alternate2 [ ] f g = 0 
  | alternate2 [x] f g = x
  | alternate2 (x::xs) f g  = alternate2 ((f (x, (hd xs)))::(tl xs)) g f ;

alternate2 [1,2,3,4] op+ op- ;

(* 4.3 *)
fun splitup [] = ([], [])
  | splitup (x::xs) = 
  let val (nonNeg, neg) = splitup xs
  in 
    if x < 0
    then (nonNeg, x::neg)
    else (x::nonNeg, neg)
  end;
splitup [1, ~2, ~4, 0, 1, 3];

(* 4.4 *)
fun composelist v [] = v
  | composelist v (x::xs) = composelist (x(v)) xs;

composelist 5 [ fn x => x+1, fn x => x*2, fn x => x-3 ];
composelist "Hello" [ fn x => x ^ " World!", fn x => x ^ " I love", fn x => x ^ " PL!"];

(* 4.5 *)
fun scan_left f y [] = [y]
| scan_left f y (x::xs) = y :: (scan_left f (f x y) xs);

scan_left (fn x => fn y => x+y) 0 [1, 2, 3];

(* 4.6 *)
fun zipRecycle (_, []) = []
  | zipRecycle ((f::fs), (s::ss)) = (f, s)::(zipRecycle ((append fs [f]), ss));

zipRecycle ([1,2,3], ["a","b","c"]);

zipRecycle ([1,2,3,4,5], ["a","b","c"]);

zipRecycle ([1,2,3], ["a","b","c","d","e"]);

zipRecycle ([1,2,3], ["a","b","c","d","e","f","g"]);

(* 4.7 *)
fun bind NONE _ f = NONE
  | bind _ NONE f = NONE 
  | bind (SOME x) (SOME y) f = SOME (f x y);

fun add x y = x + y;

bind (SOME 4) (SOME 3) add;

bind (SOME 4) NONE add;

(* 4.8 *)
fun lookup [] target = NONE
  | lookup ((k, v)::xs) target = 
      if k = target
      then SOME v
      else lookup xs target;

lookup [("hello",1), ("world", 2)] "hello";

lookup [("hello",1), ("world", 2)] "world";

lookup [("hello",1), ("world", 2)] "he";

(* 4.9 *)
fun getitem n [] = NONE
  | getitem 1 (x::_) = SOME x
  | getitem n (_::xs) = getitem (n-1) xs;

getitem 2 [1,2,3,4];

getitem 5 [1,2,3,4];

(* 4.10 *)
fun getitem2 NONE     x = NONE
  | getitem2 _       [] = NONE
  | getitem2 (SOME 1) (x::_) = SOME x
  | getitem2 (SOME n) (_::xs) = getitem2 (SOME (n-1)) xs;

getitem2 (SOME 2) [1,2,3,4];

getitem2 (SOME 5) [1,2,3,4];

getitem2 NONE [1,2,3];

getitem2 (SOME 5) [];

getitem2 (SOME 5) ([] : int list);

(* 5 *)

signature DICT =
sig
  type key = string (* concrete type *)
  type 'a entry = key * 'a (* concrete type *)
  type 'a dict (* abstract type *)
  val empty : 'a dict
  val lookup : 'a dict -> key -> 'a option
  val insert : 'a dict * 'a entry -> 'a dict
end

structure Trie :> DICT =
struct
  type key = string
  type 'a entry = key * 'a
  datatype 'a trie =
  Root of 'a option * 'a trie list
  | Node of 'a option * char * 'a trie list
  type 'a dict = 'a trie
  val empty = Root(NONE, nil)
  (* val lookup: 'a dict -> key -> 'a option *)
  (* tries to find the key in the trie,
  * returns NONE if key is not found in the trie, otherwise
  * returns a SOME(value) corresponding to this key *)
  fun lookup trie key = 
  let 
    fun lookupChildren nil _ = NONE
      | lookupChildren children keys = 
      let 
        val (child::restc) = children
        val Node(v, ch, nchildren) = child
        val (key::restk) = keys
      in 
        if ch = key
        then lookupfun child restk
        else lookupChildren restc keys
      end 
    and lookupfun (Root(SOME v, children)) nil = SOME v
      | lookupfun (Root(_, children)) keys = lookupChildren children keys
      | lookupfun (Node(v, _, _)) nil = v
      | lookupfun (Node(_, _, children)) keys = lookupChildren children keys
      
  in 
    lookupfun trie (explode key)
  end
  (* val insert: 'a dict * 'a entry -> 'a dict *)
  (* Inserts the key and value in the trie *)
  (* If the key is nil, assume that the Root is the destination *)
  fun insert (trie, (key, value)) = 
    let
      fun updateChildren(nil, key::nil, value) = [Node((SOME value), key, nil)]                       (* if trie has no child and key has one character *)
        | updateChildren(nil, key::rest, value) = [Node(NONE, key, updateChildren(nil, rest, value))] (* if trie has no child and key has more than two characters *)
        | updateChildren(children, keys, value) =                                                     (* if trie has children *)
          let 
            val (child::restc) = children
            val Node(_, ch, _) = child
            val (key::restk) = keys
          in
            if ch = key
            then insertfun(child, restk, value)::restc
            else child::updateChildren(restc, keys, value)
          end
      and
      insertfun(Root(_, children), nil, value ) = Root((SOME value), children)                               (* when root key is nil *)
        | insertfun(Root(v, children), keys, value) = Root(v, updateChildren(children, keys, value))         (* when root key is not nil *)
        | insertfun(Node(v, ch, children), keys, value) = Node(v, ch, updateChildren(children, keys, value)) (* insert into node *)
    in
      insertfun(trie, explode key, value)
    end
end
(* {
"bad" : 1,
"badge" : 2,
"icon" : 3,
"" : 4, (* empty/nil key *)
"badly". : 5
} *)
val myTrie = Trie.empty;
val myTrie = Trie.insert(myTrie, ("bad", 1));
val myTrie = Trie.insert(myTrie, ("badge", 2));

val myTrie = Trie.insert(myTrie, ("icon", 3));
val myTrie = Trie.insert(myTrie, ("", 4));
val myTrie = Trie.insert(myTrie, ("badly", 5));
val myTrie = Trie.insert(myTrie, ("", 6));

val bad = Trie.lookup myTrie "bad";  (* should return SOME(1)*)
val badge = Trie.lookup myTrie "badge"; (* should return SOME(2)*)
val icon = Trie.lookup myTrie "icon"; (* should return SOME(3)*)
val nel = Trie.lookup myTrie ""; (* should return SOME(4)*)
val badly = Trie.lookup myTrie "badly"; (* should return SOME(5)*)
val notfound = Trie.lookup myTrie "notfound"; (* should return NONE*)
val nel2 = Trie.lookup myTrie ""; (* should return SOME(6)*)

