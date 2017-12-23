//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

/// ユニフォーム画像の設定プレビュー用イメージビュー
class UniformPreviewView: UIImageView {
    
    var uniform: Uniform!
    
    /// 画像を更新する
    func reloadData() {
        image = UniformImageGenerator().generateImage(of: uniform)
    }
}
