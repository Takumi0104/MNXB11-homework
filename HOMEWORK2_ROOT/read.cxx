//
//  read.cxx
//  ROOT_homework
//
//  Created by Negoro Takumi on 2024/11/06.
//
#include <TFile.h>   // For TFile
#include <TTree.h>   // For TTree
#include <TH2F.h>    // For TH2F
#include <TRandom.h> // If you use random number generation
#include <TMath.h>   // For TMath (like Pi())
#include <iostream>  // For std::cerr and std::endl
#include "HOMEWORK.h"  //#include "HOMEWORK.h"

void read(){
    HOMEWORK *homework{nullptr};
    
    auto file = TFile::Open("tree_file.root");
    TTree *tree = static_cast<TTree*>(file->Get("tree"));
    
    tree->SetBranchAddress("homework",&homework);
    Int_t N = tree->GetEntries();
    
    TH2F *h2 = new TH2F("h2","px*pyvspz",
    100, -TMath::Pi(),TMath::Pi(),
    100,-TMath::Pi(), TMath::Pi());
    
    for(Int_t i{0}; i<N; i++){
        tree->GetEntry(i);
        h2->Fill(homework->Px() * homework->Py(), homework->Pz()); //px*py vs pz
    }
    h2->Draw("COLZ");
}
