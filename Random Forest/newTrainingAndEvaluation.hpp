/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   newTrainingAndEvaluation.hpp
 * Author: rahul
 *
 * Created on January 13, 2019, 1:37 PM
 */

#ifndef NEWTRAININGANDEVALUATION_HPP
#define NEWTRAININGANDEVALUATION_HPP

using namespace cv;
using namespace std;
using namespace ml;

class RForest
{
    public:
        vector<Ptr<DTrees>> model;
        void create(int n);
        Ptr<DTrees> train(Mat features, Mat labels);
};

#endif /* NEWTRAININGANDEVALUATION_HPP */

