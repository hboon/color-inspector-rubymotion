class UIColor
  def grayscale_colorspace?
    CGColorGetNumberOfComponents(self.CGColor) == 2
  end


  def components
    if grayscale_colorspace?
      white = Pointer.new(:float)
      alpha = Pointer.new(:float)
      self.getWhite(white, alpha:alpha)
      [white[0], alpha[0]]
    else
      red = Pointer.new(:float)
      green = Pointer.new(:float)
      blue = Pointer.new(:float)
      alpha = Pointer.new(:float)
      self.getRed(red, green:green, blue:blue, alpha:alpha)
      [red[0], green[0], blue[0], alpha[0]]
    end
  end


  def red
    (components[0]*255).round
  end


  def green
    (components[1]*255).round
  end


  def blue
    (components[2]*255).round
  end


  def alpha
    if grayscale_colorspace?
      components[1]
    else
      components[3]
    end
  end


  def white
    components[0]
  end


  def color_with_alpha(a)
    comps = components
    UIColor.alloc.initWithRed(comps[0], green:comps[1], blue:comps[2], alpha:a)
  end
end
