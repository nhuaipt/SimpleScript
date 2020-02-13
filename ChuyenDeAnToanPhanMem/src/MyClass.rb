
class MyClass #(change name)
 
  include GladeGUI

  def before_show()
    @button1 = "Hello World"
  end  

  def button_encode__clicked(*args)
  	EncodeClass.new.show_glade()
  end

  def button_decode__clicked(*args)
  	DecodeClass.new.show_glade()
  end

end

