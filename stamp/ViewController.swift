//
//  ViewController.swift
//  stamp
//
//  Created by tatsuomi kikawa on 2020/09/19.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //stamp画像の配列
    var imageNameArray: [String] = ["hana", "hoshi", "onpu", "shitumon" ]
    
    //スタンプの画像番号
    var imageIndex: Int = 0
    
    //背景画像を表示するimageview
    @IBOutlet var haikeiImageView: UIImageView!
    
    //スタンプ画像が入るimageview
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //touchされた時に行われる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //touchした位置を習得する
        let touch: UITouch = touches.first!//touchesがタッチされた時，その中の1つを習得するのがfirst
        let location: CGPoint = touch.location(in: self.view)//self.view（viewcontroller全体）での位置を習得する
        
        //押すスタンプが選ばれている時の処理
        if imageIndex != 0 {
            
            //stampサイズの指定
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            
            //押されたスタンプの画像設定
            let image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
            
            //タッチされた位置に画像を置く
            imageView.center = CGPoint(x: location.x, y: location.y)
            
            //画像を表示する
            self.view.addSubview(imageView)
        }
        
    }
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    @IBAction func back() {
        //2回続けてremoveできない
        self.imageView.removeFromSuperview()
    }
    
    @IBAction func selectBackground() {
        
        //UIimagepickerControllerのインスタンス作成
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        //photoライブラリの設定
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //photoライブラリを呼び出す
        self.present(imagePickerController, animated:true, completion: nil)//self.presentは画面遷移するメソッド，imagePickerControllerを呼び出す
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //アクセス権も設定しなければならない
        //->info.plist
        //imageに選んだ画像を設定する
        let image = info[.originalImage] as? UIImage
        //背景に選択する
        haikeiImageView.image = image
        
        //photoライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        
        //画面上のスクリーンショットを習得する
        let rect: CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        
        UIGraphicsBeginImageContext(rect.size)
        
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        //photoライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }
}

