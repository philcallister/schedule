class SplashViewController < UIViewController
  
  def viewDidLoad
    super

    ai = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivity::UIActivityIndicatorViewStyleWhite)
    ai.center = self.view.center
    ai.startAnimating
    self.view.addSubview(ai)
  end

  def viewDidAppear(animated)
    super

    sleep 1

    Club.force_load do
      inc = self.storyboard.instantiateViewControllerWithIdentifier('InitialSlidingView')
      self.presentViewController(inc, animated:true, completion:nil)
    end
  end

end