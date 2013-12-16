class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window.makeKeyAndVisible
    window.rootViewController = ViewController.new

    true
  end
end


class ViewController < UIViewController
  def initWithNibName(nibName, bundle:nibBundle)
    super
    view.backgroundColor = UIColor.yellowColor
    btn = UIButton.buttonWithType(UIButtonTypeSystem)
    btn.frame = [[110,30], [100, 30]]
    btn.setTitle('Button', forState:UIControlStateNormal)
    btn.tintColor = UIColor.redColor
    btn.addTarget(self, action:'clicked:', forControlEvents:UIControlEventTouchUpInside)
    view.addSubview(btn)

    v = UIView.alloc.initWithFrame([[50, 100], [200, 100]])
    v.backgroundColor = UIColor.greenColor
    view.addSubview(v)

    self
  end

  #Events
  def clicked(b)
    b.edit_tint
  end
end
