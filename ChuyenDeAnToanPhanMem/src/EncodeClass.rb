class EncodeClass
	
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

  def button_encode__clicked(*args)
  		file = @builder["entry"].text 
  		mess = @builder["entry_mess"].text
  		k = @builder["entry_k"].text

      
  		empty = file.empty? || mess.empty? || k.empty?
      k = k.to_i
  		if empty
  			alert "Ban chua nhap du thong tin..!"
  		else
          if k >= 2
  			   encode  = Encode.new(file,mess,k)
  			   alert encode.encode
        
         else 
          alert "Khoa K phai lon hon hoac bang 2"
         end
  		end 
  end 
end