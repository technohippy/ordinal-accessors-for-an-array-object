= ArrayOrdinalAccessor

* ANDO Yasushi (http://d.hatena.ne.jp/technohippy)

== DESCRIPTION:

This library allows you to access to items of an array object by ordinal-number-methods
such as: seventy_third, one_hundred_and_ninty and so on. This is inspired by the DHH's 
cool enhancement for Rails 2.2:  
http://github.com/rails/rails/commit/22af62cf486721ee2e45bb720c42ac2f4121faf4

== FEATURES/PROBLEMS:

* This library overwrote Array#method_missing. This cause some problems.

== SYNOPSIS:

  >> require 'array_ordinal_accessor'
  => true
  >> array = (1..200000).to_a
  ..snip..
  >> array.seventy_third
  => 73
  >> array.three_hundred_and_nineth
  => 309 
  >> array.one_hundred_thirty_two_thousand_six_hundred_and_forty_eighth
  => 132648
  >> array[-17230]
  => 182771
  >> array.seventeen_thousand_two_hundred_and_thirty_from_last
  => 182771
  >> array.sixty_one_thousand_one_hundred_and_twelveth_to_sixty_one_thousand_one_hundred_and_twentieth
  => [61112, 61113, 61114, 61115, 61116, 61117, 61118, 61119, 61120]
  >> array[61111..61119]
  => [61112, 61113, 61114, 61115, 61116, 61117, 61118, 61119, 61120]

== INSTALL:

* sudo gem install array_ordinal_accessor

== LICENSE:

(The MIT License)

Copyright (c) 2008 ANDO Yasushi

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
