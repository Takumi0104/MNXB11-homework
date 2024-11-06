//
//  write.cxx
//  ROOT_homework
//
//  Created by Negoro Takumi on 2024/11/06.
//

#include "HOMEWORK.h"
#include <TFile.h>
#include <TTree.h>
#include <TRandom.h>
#include <iostream>

void write(){
    
    HOMEWORK *homework{nullptr};
    TFile f("tree_file.root","RECREATE");
    
    if (f.IsZombie()) {
    std::cerr << "Error creating file tree_file.root" << std::endl;
            return;
        }
    
    
    TTree *tree = new TTree("tree", "homework tree");
    tree->Branch("homework", &homework);
    
    Double_t px, py, pz;
    Int_t ev;
    for (Int_t i{0}; i<100000; i++){
        gRandom->Rannor(px,py);
        pz = px*px + py*py;
        ev = i;
        homework = new HOMEWORK(ev, px, py, pz);
        tree->Fill();
        delete homework;
        
    }
    tree->AutoSave();
}




