class Decode
	def initialize(file,k)
		@file = file
		@k = k
	
	end

	def decode
		array = FileToASCII(@file)
		binary = ArrayAsciiToBinary(array)
		
		string_array = SplitString(binary)
		mess = ConvertToMess(string_array)
		return mess
		

	end

	def ConvertToMess(string_array)
		binary = ""
		dem = 0
		string_array.each do |item|
			string = item[0..1]
			if string == "01"
				binary = binary + "0"
				dem += 1
			elsif string == "10"
				binary = binary + "1"
				dem += 1
			end
		end

		string = ""
		length = binary.length
		for i in 1..length/8
			string = string + binary[0..7]

			binary = binary[8..length]
		end
	
		data_array = Array.new()
		data_array.push(string)
		

		return data_array.pack("B*")


	end

	def SplitString(binary)
		string_binary = binary
		array = Array.new
		for i in 0..binary.length/@k
			string = string_binary[0..@k-1]
			array.push(string)
			string_binary = string_binary[@k..string_binary.length-1]
		end
		return array

	end
	
	def ArrayAsciiToBinary(array)
		binary = ""
		length = array.length
		i = 0
		while i < length 
			item = array[i]
			item1 = array[i+1]		
			if item == 32 && item1 == 32
				binary = binary + "1"
				i +=2
			elsif item == 32
				binary = binary + "0"
				i +=1
			else i +=1
				
			end

		end
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