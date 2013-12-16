class ColorInspector < UIView
  #kkk weak ref for target_view?
  attr_accessor :target_view, :reader_selector, :writer_selector, :type
  attr_accessor :r_slider, :g_slider, :b_slider, :a_slider, :r_label, :g_label, :b_label, :a_label

  def self.show_for(aView, type:aSymbol)
    v = self.alloc.initWithFrame([[0, 0], [300, 190]])
    v.type = aSymbol
    v.target_view = aView
    if v.type == :fg
      if aView.kind_of? UIButton
        v.reader_selector = 'titleColorForState:'
        v.writer_selector = 'setTitleColor:forState:'
      else
        v.reader_selector = 'textColor'
        v.writer_selector = 'textColor='
      end
    elsif v.type == :tint
        v.reader_selector = 'tintColor'
        v.writer_selector = 'tintColor='
    else
        v.reader_selector = 'tintColor'
        v.reader_selector = 'backgroundColor'
        v.writer_selector = 'backgroundColor='
    end

    UIApplication.sharedApplication.delegate.window.endEditing(true)
    parent = UIApplication.sharedApplication.delegate.window
    v.center_x = parent.width/2
    v.center_y = parent.height/2
    parent.addSubview(v)
    v
  end


	def initWithFrame(rect)
		super

    self.backgroundColor = UIColor.clearColor
    layer.cornerRadius = 7
    layer.masksToBounds = true

    bg_v = UIView.alloc.initWithFrame(bounds)
    bg_v.backgroundColor = BWFake::rgba_color(0, 0, 0, 0.6)
    addSubview(bg_v)

    margin = 7

    r_slider_label = UILabel.alloc.initWithFrame([[margin, margin*2], [50, 20]])
    r_slider_label.textColor = UIColor.whiteColor
    r_slider_label.text = 'Red'
    addSubview(r_slider_label)

    g_slider_label = UILabel.alloc.initWithFrame([[r_slider_label.left, r_slider_label.bottom+20], [r_slider_label.width, r_slider_label.height]])
    g_slider_label.textColor = r_slider_label.textColor
    g_slider_label.text = 'Green'
    addSubview(g_slider_label)

    b_slider_label = UILabel.alloc.initWithFrame([[r_slider_label.left, g_slider_label.bottom+20], [r_slider_label.width, r_slider_label.height]])
    b_slider_label.textColor = r_slider_label.textColor
    b_slider_label.text = 'Blue'
    addSubview(b_slider_label)

    a_slider_label = UILabel.alloc.initWithFrame([[r_slider_label.left, b_slider_label.bottom+20], [r_slider_label.width, r_slider_label.height]])
    a_slider_label.textColor = r_slider_label.textColor
    a_slider_label.text = 'Alpha'
    addSubview(a_slider_label)

    self.r_label = UILabel.alloc.initWithFrame([[0, 0], [200, 20]])
    r_label.right = width - margin
    r_label.center_y = r_slider_label.center_y
    r_label.text = "255.0"
    r_label.size_width_to_fit_align_right
    r_label.text = ''
    r_label.textColor = UIColor.whiteColor
    addSubview(r_label)

    self.g_label = UILabel.alloc.initWithFrame([[r_label.left, r_label.top], [r_label.width, r_label.height]])
    g_label.center_y = g_slider_label.center_y
    g_label.textColor = r_label.textColor
    addSubview(g_label)

    self.b_label = UILabel.alloc.initWithFrame([[r_label.left, r_label.top], [r_label.width, r_label.height]])
    b_label.center_y = b_slider_label.center_y
    b_label.textColor = r_label.textColor
    addSubview(b_label)

    self.a_label = UILabel.alloc.initWithFrame([[r_label.left, r_label.top], [r_label.width, r_label.height]])
    a_label.center_y = a_slider_label.center_y
    a_label.textColor = r_label.textColor
    addSubview(a_label)

		self.r_slider = UISlider.alloc.initWithFrame([[r_slider_label.right+2, 0], [width-2*margin-r_slider_label.width-r_label.width-margin, 44]])
    r_slider.center_y = r_slider_label.center_y
		r_slider.backgroundColor = UIColor.clearColor
		r_slider.minimumTrackTintColor = UIColor.whiteColor
		r_slider.maximumTrackTintColor = UIColor.redColor
    r_slider.minimumValue = 0
    r_slider.maximumValue = 255
    r_slider.addTarget(self, action:'update_color', forControlEvents:UIControlEventValueChanged)
		addSubview(r_slider)

		self.g_slider = UISlider.alloc.initWithFrame([[r_slider.left, 0], [r_slider.width, r_slider.height]])
    g_slider.center_y = g_slider_label.center_y
		g_slider.backgroundColor = UIColor.clearColor
		g_slider.minimumTrackTintColor = UIColor.whiteColor
		g_slider.maximumTrackTintColor = UIColor.greenColor
    g_slider.minimumValue = 0
    g_slider.maximumValue = 255
    g_slider.addTarget(self, action:'update_color', forControlEvents:UIControlEventValueChanged)
		addSubview(g_slider)

		self.b_slider = UISlider.alloc.initWithFrame([[r_slider.left, 0], [r_slider.width, r_slider.height]])
    b_slider.center_y = b_slider_label.center_y
		b_slider.backgroundColor = UIColor.clearColor
		b_slider.minimumTrackTintColor = UIColor.whiteColor
		b_slider.maximumTrackTintColor = UIColor.blueColor
    b_slider.minimumValue = 0
    b_slider.maximumValue = 255
    b_slider.addTarget(self, action:'update_color', forControlEvents:UIControlEventValueChanged)
		addSubview(b_slider)

		self.a_slider = UISlider.alloc.initWithFrame([[r_slider.left, 0], [r_slider.width, r_slider.height]])
    a_slider.center_y = a_slider_label.center_y
		a_slider.backgroundColor = UIColor.clearColor
		a_slider.minimumTrackTintColor = UIColor.whiteColor
		a_slider.maximumTrackTintColor = UIColor.blackColor
    a_slider.minimumValue = 0
    a_slider.maximumValue = 1.0
    a_slider.addTarget(self, action:'update_color', forControlEvents:UIControlEventValueChanged)
		addSubview(a_slider)

    close_btn = UIButton.buttonWithType(UIButtonTypeSystem)
    close_btn.frame = [[0, 0], [100, 20]]
    close_btn.right = width-margin
    close_btn.bottom = height-margin
    close_btn.tintColor = BWFake::rgba_color(255, 255, 255, 1)
    close_btn.setTitle('Close', forState:UIControlStateNormal)
    close_btn.size_width_to_fit_align_right
    close_btn.addTarget(self, action:'close', forControlEvents:UIControlEventTouchUpInside)
    addSubview(close_btn)

		@panGestureRecognizer = UIPanGestureRecognizer.alloc.initWithTarget(self, action:'dragged:')
		@panGestureRecognizer.maximumNumberOfTouches = 1
    addGestureRecognizer(@panGestureRecognizer)

		self
	end


  def red_component
    r_slider.value.to_i
  end


  def green_component
    g_slider.value.to_i
  end


  def blue_component
    b_slider.value.to_i
  end


  def alpha_component
    a_slider.value.round(2)
  end


  def update_labels
    r_label.text = red_component.to_s
    g_label.text = green_component.to_s
    b_label.text = blue_component.to_s
    a_label.text = alpha_component.to_s
  end


  def update_sliders
    return if target_view.nil? || reader_selector.nil?

    if (target_view.kind_of? UIButton) && type == :fg
      c = target_view.send(reader_selector, UIControlStateNormal)
    else
      c = target_view.send(reader_selector)
    end
    if c.nil?
      r_slider.value = 0
      g_slider.value = 0
      b_slider.value = 0
      a_slider.value = 0
    elsif c.grayscale_colorspace?
      r_slider.value = c.white*255
      g_slider.value = c.white*255
      b_slider.value = c.white*255
      a_slider.value = c.alpha
    else
      r_slider.value = c.red
      g_slider.value = c.green
      b_slider.value = c.blue
      a_slider.value = c.alpha
    end

    update_labels
  end


  def update_color
    update_labels
    c = BWFake::rgba_color(red_component, green_component, blue_component, alpha_component)
    #kkk this crashes if we slide many times, maybe quickly using performSelector:
    #target_view.performSelector(sel, withObject:c)
    if (target_view.kind_of? UIButton) && type == :fg
      target_view.send(writer_selector, c, UIControlStateNormal)
    else
      target_view.send(writer_selector, c)
    end
  end

  #Accessors

  def target_view=(v)
    @target_view = v
    update_sliders
  end


  def reader_selector=(aString)
    @reader_selector = aString
    update_sliders
  end

  #Actions

  def close
    NSLog("rgba #{red_component}, #{green_component}, #{blue_component}, #{alpha_component}")
    @panGestureRecognizer.view.removeGestureRecognizer(@panGestureRecognizer)
    removeFromSuperview
  end

  def dragged(panRecognizer)
    case panRecognizer.state
    when UIGestureRecognizerStateBegan
      @origin_before_pan = frame.origin
    when UIGestureRecognizerStateChanged
      changed = panRecognizer.translationInView(self)
      self.left = @origin_before_pan.x+changed.x
      self.top = @origin_before_pan.y+changed.y
    end
  end
end


class UIView
  def edit_bg
    ColorInspector.show_for(self, type: :bg)
  end


  def edit_fg
    ColorInspector.show_for(self, type: :fg)
  end


  def edit_tint
    ColorInspector.show_for(self, type: :tint)
  end
end



#This is here just to remove the dependency on BubbleWrap for showcasing purposes. https://github.com/rubymotion/BubbleWrap
#Replace BWFake with BW once we can include BubbleWrap
module BubbleWrapFake
  module_function

  def rgba_color(r,g,b,a)
    r,g,b = [r,g,b].map { |i| i / 255.0}
    UIColor.colorWithRed(r, green: g, blue:b, alpha:a)
  end
end

BWFake = BubbleWrapFake
