class DecodeClass
	
  include GladeGUI
  
  def before_show()
  end

  def button_file__clicked(*args)
  	 file = String.new
     dialog = Gtk::FileChooserDialog.new( :title => "Open File",
                                         :parent => nil,
                                        :action => Gtk::FileChooserAction::OPEN,
                                        :buttons => 
                                       [[Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL],
                                       [Gtk::Stock::OPEN , Gtk::ResponseType::ACCEPT]])
     if dialog.run == Gtk::ResponseType::ACCEPT
         file = dialog.filename
      end
      dialog.destroy
      if !file.empty?
    	  @builder["entry"].text = file 

  		end
  end
  
  def button_decode__clicked(*args)
  	 file = @builder["entry"].text 
     k = @builder["entry_k"].text
      empty = file.empty? || k.empty?
      k = k.to_i
      if empty
        alert "Ban chua nhap du thong tin..!"
      else
        if k >= 2
          decode  = Decode.new(file,k)
          @builder["label"].text = decode.decode
         else 
          alert "Khoa K phai lon hon hoac bang 2"
         end
      end 
  end 
end