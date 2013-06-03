# Karma to Burn

## Purpose and Overview:

The purpose of this application is to promote healthy living and regulate decadence. It is as much for myself as it is for you. It is a sometimes not-so-friendly reminder that in order to spend karma, you should first earn it.

In his 1943 paper, 'A Theory of Human Motivation', Abraham Maslow asserts that physiological, safety, belongingness and love, esteem, self-actualization and self-transcendence are the underlying needs of human beings. This assertion is commonly referred to as Maslow's Hierarchy of Needs. The user of this application is awarded (or berated) based by his/her general ability to satiate these needs. As such, Karma to Burn is loosely based on the Hierarchy of Needs.

The user is prompted questions about his/her daily exploits which require a 'true' or 'false' response. One Karma Point is awarded for every response that demonstrates a satiated need. No Karma Points are awarded for a response that demonstrates otherwise. Karma Points are tallied and stored after all daily responses have been submitted. After daily responses have been submitted, the user has the options to redeem Karma Points for minutes of earned leisure (six minutes per point) or view progress a progress report.

A user can log Karma Points only once a day though he/she can return to the program any number of times a day to view progress and/or spend Karma Points (assuming the user has a balance of more than 0 Karma Points).

## Usage Instructions:

To run the program, the user must type 'ruby ktb'. Thereafter, instructions are provided by the application itself.

## Project Status:

[![Code Climate](https://codeclimate.com/github/shaynarang/NSS-Karma-to-Burn.png)](https://codeclimate.com/github/shaynarang/NSS-Karma-to-Burn)
[![Build Status](https://travis-ci.org/github.com/shaynarang/NSS-Karma-to-Burn.png)](https://travis-ci.org/github.com/shaynarang/NSS-Karma-to-Burn)

As of 05-27-2013, this application effectively prompts users, accepts responses, aggregates data, and provides feedback accordingly.

## Known Bugs:

- As of 05-27-2013, there is an issue aggregating data for multiple users with the same name. A first user with any name can be successfully added to the SQLite Database with no issue. However, should a second user with the exact same name as the first user get entered, the SQLite database does not create and store a unique id for this second user, nor does it point to the first user.
- As of 05-27-2013, there is sometimes an issue when a user answers a question with a value that is not 'true' or 'false'. The command line will sometimes prompt the user with the same question several times thereafter. 

## To Do:

- The known bugs as of 05-27-2013 needs to be addressed
- Name and date of birth validation needs to be added
- It may be beneficial to include individual categories on the progress chart
- The file structure needs to be updated: some of the methods in the executable ktb.rb file should belong to models

## Demo:

To demo this application, you must download it and try it yourself.

## Author:

Shay Narang

## License:

Copyright (c) 2013 Akshay 'Shay' Narang

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.