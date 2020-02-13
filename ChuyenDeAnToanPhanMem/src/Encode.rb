class Encode

	def initialize(file,mess,k)
		@file = file
		@mess = mess
		@k = k
		@ARRAY = Array.new	
	end

	def encode()
		mess_binary = StringToBinary(@mess)
		array = FileToASCII(@file)
		count = CountSpaceFile(array)

		if (count/@k) >= mess_binary.length
			SplitString(array)
			Add(mess_binary)
			WriteFile()
			
			return "BAN GIAU TIN THANH CONG"
		else
			return "THONG BAO: TAP TIN QUA NGAN"
		end



	end

	def WriteFile

		array = @ARRAY.flatten
		
		array_byte = Array.new
		array.each do |item|
			
			binary = IntegerToBinary(item)
			array_byte.push(binary)
		end
		array_byte = array_byte.join
		array_binary = Array.new
		array_binary.push(array_byte)
		
		array = @file.split("/")
		file_hidden = array[array.length-1].split(".")
		array.delete_at(array.length-1)
		array.delete_at(0)
		link_hidden = "/"
		array.each {|x| link_hidden = link_hidden + x + "/" } 
		link_hidden = link_hidden + file_hidden[0] + "_hidden." + file_hidden[1]

		File.open(link_hidden , 'wb') do|f| # write new file , with @data_output is Array binary (Array.length == 1) 
	  			f.write(array_binary.pack("B*")) 
	  			
		end
	end

	def IntegerToBinary(number)
		number = number.to_i
		binary = number.to_s(2)
		if binary.length < 8
			for i in 1..8-binary.length
				binary = "0" + binary

			end
		end
		return binary
	end

	def Add(mess_binary)
		
	
		for i in 0..mess_binary.length-1
			char = mess_binary[i]
			array = @ARRAY[i]
			array_temp = Array.new

			case char
			when "1"
				
				flag = false
				array.each do |item|

					if item == 32 && flag == false
						array_temp.push("32")
						flag = true
					end
					array_temp.push(item)
				end
				@ARRAY[i] = array_temp
				
				
			when "0"
				
				count = 0
				flag = false
				array.each do |item|

					if item == 32 && flag == false 
						count +=1
					end
					if count == 2 && flag == false
						flag = true
						array_temp.push("32")
					end
					array_temp.push(item)
				end
				@ARRAY[i] = array_temp
			
			
			
			end
				
		end
		
	end


	def SplitString(array_file)
		count = 0
		array = Array.new
		array_file.each do |item|
			if count == @k
				@ARRAY.push(array)
				array = Array.new
				count = 0
			end
			if item == 32
				count +=1
			end
			array.push(item)		
		end
		if count != 0
			@ARRAY.push(array)
		end

	end

	def CountSpaceFile(array)
		count = 0
		array.each do |item|
			if item == 32
				count += 1
			end
		end

		return count 

	end

	def StringToBinary(mess)
		binary = mess.unpack("B*")
		binary = binary.pop
		return binary
	end


	def FileToASCII(file)
		array = Array.new
		file = File.binread(@file)
		file.each_byte do |c|
   			 array.push(c)
   		end

		return array
	end




end