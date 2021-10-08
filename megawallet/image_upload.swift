//
//  image_upload.swift
//  megawallet
//
//  Created by hu on 2021/9/22.
//

import SwiftUI
import web3swift

struct image_upload: View {
    @State private var showingNFTContent = false
    @State private var showingImagePicker = false
    @State private var image1: Image?
    @State private var inputImage: UIImage?
    @ObservedObject var tfMgr=TextBindingManager()
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image1 = Image(uiImage: inputImage)
    }
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    if image1 != nil {
                        image1?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to upload a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                Button(action: {
                    tfMgr.Imgae = self.inputImage
                    if self.image1 == nil{
                        print("fail1")
                    }
                    if self.inputImage == nil{
                        print("fail2")
                    }
                    if tfMgr.Imgae == nil{
                        print("fail3")
                    }
                    self.showingNFTContent.toggle()
                }){
                    Text("upload")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("photo_upload")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .sheet(isPresented: $showingNFTContent){
                NFT_Content()
                    .environmentObject(tfMgr)
            }
        }
    }
}

struct image_upload_Previews: PreviewProvider {
    static var previews: some View {
        image_upload()
    }
}
