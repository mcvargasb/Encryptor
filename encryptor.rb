require 'digest'
class Encryptor
 def supported_characters
  (' '..'z').to_a
 end

 def crack(message)
  supported_characters.count.times.collect do |attempt|
   decrypt(message,attempt)
  end
 end 

def encrypt_letter(letter,rotation)
   lowercase_letter = letter
   cipher_for_rotation = cipher(rotation)
   cipher_for_rotation[lowercase_letter]
 end  

 def encrypt(string,rotation)
  letters = string.split("")
 
  results = []
  letters.each do |letter|
   encrypted_letter = encrypt_letter(letter,rotation)
   results.push(encrypted_letter)
  end
 
 results.join
end

 def superencrypt(string)
  letters = string.split("")
  rotation = 13
  results = []
  letters.each do |letter|
   encrypted_letter = encrypt_letter(letter,rotation)
   results.push(encrypted_letter)
   if rotation == 13
   rotation = 10
   elsif rotation == 10
   rotation = 2
   elsif rotation == 2
   rotation = 13
   end  
  end
  results.join
end


 def decrypt_letter(letter,rotation)
   lowercase_letter = letter
   dcipher_for_rotation = dcipher(rotation)
   dcipher_for_rotation[lowercase_letter]
 end

 def superdecrypt(string)
  letters = string.split("")
  rotation = 13
  results = []
  letters.each do |letter|   
  decrypted_letter = decrypt_letter(letter,rotation)
  results.push(decrypted_letter)
  if rotation == 13
   rotation = 10
   elsif rotation == 10
   rotation = 2
   elsif rotation == 2
   rotation = 13
   end
 end

results.join
end

 def decrypt(string, rotation)
  letters = string.split("")

  results = []
  letters.each do |letter|
   decrypted_letter = decrypt_letter(letter,rotation)
   results.push(decrypted_letter)
  end

results.join
end


def dcipher(rotation)
 characters = ((' '..'z').to_a).reverse
 rotated_characters = characters.rotate(rotation)
 Hash[characters.zip(rotated_characters)]
end
 

def cipher(rotation)
 characters = (' '..'z').to_a
 rotated_characters = characters.rotate(rotation)
 Hash[characters.zip(rotated_characters)]
end

def encrypt_file(secret, rotation)

# 1. Create the file handle to the input file

input = File.open("secret.txt", "r")

# 2. Read the text of the input file

texto = input.read 

# 3. Encrypt the text

texto2 = encrypt(texto,rotation)

# 4. Create a name for the output file

secret1 = secret.gsub("encrypted", "decrypted")

# Write out the text

input2 = File.open("secret1.txt", "w")
input2.write(texto2)

# Close the file

input2.close
end

def decrypt_file(secret1,rotation)

# 1. Create the file handle to the encrypted file

input = File.open("secret1.txt", "r")

# 2. Read the encrypted text

texto = input.read 

# 3. Decrypt the text by passing in the next and rotation

texto2 = decrypt(texto,rotation)

# 4. Create a name for the decrypted file

input2 = File.open("secret2.txt","w")

# 5. Create an output file handle

secret2 = secret1.gsub("encrypted", "decrypted")

# 6. Write out the text

input2.write(texto2)

# 7. Close the file

input2.close
end
end

system("clear")
puts "Hello! this is the REAL-TIME ENCRYPTION! First, introduce the password:"

password = gets.chomp
 e = Encryptor.new
 
# if password == e.decrypt("nzor$ov&",13)
 md5 = Digest::MD5.new
 codificada = md5.hexdigest(password) 

  if codificada == 'dddb281cd5f829513bef33f08905b0ff'
   puts "To encrypt a message type 1. To decrypt it type 2:"
   number = gets.to_i
 if number == 1
  system("clear")
  puts "Hello, this is the Encryptor program.\nIntroduce your message to encrypt:\n"
  message = gets
  puts "I have got your message! Now introduce the number of rotation:"
  rotation = gets.to_i
  e = Encryptor.new
  puts "Your encrypted message is: #{e.encrypt(message, rotation)}"

 elsif number == 2
  system("clear")
  puts "Hello, this is the Encryptor program.\nIntroduce the message to decrypt:"
  message = gets 
  puts "I have got your message! Now introduce the number of rotation:"
  rotation = gets.to_i
  e = Encryptor.new
  puts "Your decrypted message is: #{e.decrypt(message, rotation)}"
end
else 
 puts "Invalid password"
end
