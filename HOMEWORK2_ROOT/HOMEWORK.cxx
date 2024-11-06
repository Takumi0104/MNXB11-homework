//
//  HOMEWORK.cxx
//  ROOT_homework
//
//  Created by Negoro Takumi on 2024/11/05.
//
#include "HOMEWORK.h"

ClassImp(HOMEWORK)

HOMEWORK::HOMEWORK() :
ev{0},
px{0},
py{0},
pz{0},
L{nullptr}
{
}
HOMEWORK::HOMEWORK(Int_t ev, Double_t px, Double_t py, Double_t pz) :
ev{ev},
px{px},
py{py},
pz{pz},
L{nullptr}
{
    InitializeVector();
}
HOMEWORK::~HOMEWORK(){
    if(L){ delete L; }
}
void HOMEWORK::InitializeVector(){
    if(!L) L = new TVector3(px,py,pz);
}
Double_t HOMEWORK::Phi(){
    return L->Phi();
}

Double_t HOMEWORK::Pt(){
    return L->Pt();
}
