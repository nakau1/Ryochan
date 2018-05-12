//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

protocol TopPagedPortraitsViewPagingDelegate: class {
    
    func numberOfImages(in topPagedPortraitsView: TopPagedPortraitsView) -> Int
    
    func topPagedPortraitsView(_ topPagedPortraitsView: TopPagedPortraitsView, imageAt index: Int) -> UIImage?
    
    func topPagedPortraitsView(_ topPagedPortraitsView: TopPagedPortraitsView, sizeInContainer rect: CGSize) -> CGSize?
    
    func topPagedPortraitsViewDidStartScroll(_ topPagedPortraitsView: TopPagedPortraitsView)
    
    func topPagedPortraitsViewDidEndScroll(_ topPagedPortraitsView: TopPagedPortraitsView, to index: Int)
}

class TopPagedPortraitsView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var pagingDelegate: TopPagedPortraitsViewPagingDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        self.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagingDelegate?.numberOfImages(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopPagedPortraitsCell
        cell.image = pagingDelegate?.topPagedPortraitsView(self, imageAt: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class TopPagedPortraitsCell: UICollectionViewCell {
    
    @IBOutlet private weak var portraitImageView: UIImageView!
    
    var image: UIImage? {
        get {
            return portraitImageView.image
        }
        set {
            portraitImageView.image = newValue
        }
    }
}

/*
protocol PagingImageViewDataSource: class {
    
    func numberOfImages(in pagingImageView: PagingImageView) -> Int
    
    func pagingImageView(_ pagingImageView: PagingImageView, imageAt index: Int) -> UIImage?
    
    func pagingImageView(_ pagingImageView: PagingImageView, sizeInContainer rect: CGSize) -> CGSize?
}

protocol PagingImageViewDelegate: class {
    
    func pagingImageViewDidStartScroll(_ pagingImageView: PagingImageView)
    
    func pagingImageViewDidEndScroll(_ pagingImageView: PagingImageView, to index: Int)
}

class PagingImageView: UIScrollView, UIScrollViewDelegate {
    
    weak var dataSource: PagingImageViewDataSource?
    weak var pagingDelegate: PagingImageViewDelegate?
    
    private var scrolling = false
    private(set) var currentPage = 0
    
    func reloadData() {
        removeAllImageViews()
        setupScrollView()
        addAllImageViews()
        updateContentSize()
        updateInvisiblePageImages()
    }
    
    private func setupScrollView() {
        delegate = self
        isPagingEnabled = true
        bounces = false
        showsHorizontalScrollIndicator = false
    }
    
    private func removeAllImageViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func addAllImageViews() {
        let num = (dataSource?.numberOfImages(in: self) ?? 0)
        
        (0..<num).forEach {
            let frame = CGRect(
                $0.f * bounds.width,
                0,
                bounds.width,
                bounds.height
            )
            let imageView = UIImageView(frame: frame)
            imageView.contentMode = .scaleAspectFit
            imageView.image = dataSource?.pagingImageView(self, imageAt: $0)
            
            addSubview(imageView)
        }
    }
    
    private func updateInvisiblePageImages() {
        
        
        
        
        
    }
    
    private func updateContentSize() {
        let num = (dataSource?.numberOfImages(in: self) ?? 0)
        contentSize = CGSize(num.f * bounds.width, bounds.height)
    }
    
    /// スクロール開始の処理
    private func didRecognizeBeginScroll() {
        print("start")
        scrolling = true
    }
    
    /// スクロール終了の処理
    private func didRecognizeEndScroll() {
        print("end")
        currentPage = calculateCurrentPage()
        updateInvisiblePageImages()
        scrolling = false
    }
    
    /// スクロール終了の処理
    private func didRecognizeScrolling() {
        // Nop.
    }
    
    private func calculateCurrentPage() -> Int {
        return lround(Double(contentOffset.x / bounds.width))
    }
    
    /// スクロールビューがスクロールされた時
    /// - parameter scrollView: スクロールビュー
    @objc func scrollViewDidScroll(scrollview: UIScrollView) {
        //self.decideCurrentPage(scrollView)
        self.didRecognizeScrolling()
    }
    
    /// スクロールビューのドラッグ開始時
    /// - parameter scrollView: スクロールビュー
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrolling {
            didRecognizeEndScroll()
        }
        didRecognizeBeginScroll()

    }
    /// スクロールビューの減速が終わった時
    /// - parameter scrollView: スクロールビュー
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didRecognizeEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.didRecognizeEndScroll()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.didRecognizeEndScroll()
    }
}
*/
