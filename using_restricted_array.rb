require_relative 'restricted_array.rb'
# RestrictedArray can be created using a specified size, or a random size in
# the range of 1-20 will be chosen for you.
# All values are integers in the range of 1-221.
# RestrictedArray cannot be resized.
# An unused space in the restricted array has the 'SPECIAL_VALUE'
SPECIAL_VALUE = 9999

## Calculates the length of the restricted integer array_size
def length(array)
  length = 0
  until array[length] == nil
    length +=1
  end
  return length
  # puts "NOT IMPLEMENTED"
end

# Prints each integer values in the array
def print_array(array)
  index = 0
  until array[index] == nil
    if index == 0
      print array[index].to_s
    else
      print " " + array[index].to_s
    end
    index += 1
  end
  # puts "NOT IMPLEMENTED"
end

# Reverses the values in the integer array
def reverse(array, length) # Ruby
  i = 0
  j = length - 1
  until i > j
    temp_i = array[i]
    array[i] = array[j]
    array[j] = temp_i
    i += 1
    j -= 1
  end
  return array
  # puts "NOT IMPLEMENTED"
end

# For an unsorted array, searches for 'value_to_find'.
# Returns true if found, false otherwise.
def search(array, length, value_to_find)
  index = 0
  while index < length
    if array[index] == value_to_find
      return true
    end
    index += 1
  end
  return false
  # puts "NOT IMPLEMENTED"
end

def search_sorted(array, left_index, right_index, value_to_find)
  # Binary Search
  if right_index >= left_index
    middle_index = (right_index+left_index)/2
    if array[middle_index] == value_to_find
      return middle_index
    end
    if array[middle_index] < value_to_find
      return search_sorted(array, (middle_index + 1), right_index, value_to_find)
    end
    if array[middle_index] > value_to_find
      return search_sorted(array, left_index, (middle_index - 1), value_to_find)
    end
  end
  return nil
end

# Sorts the array in ascending order.
def sort(array, length)
  # SELECTION sort
  for index in 0...length-1
    # find min in the array with index higher than "index"
    ind_min = index + 1
    min = array[ind_min]
    for ind in ind_min...length
      if array[ind] < min
        ind_min = ind
        min = array[ind]
      end
    end

    # swap if value for ind_min is less than value for index
    if array[index] > min
      temp = array[index]
      array[index] = min
      array[ind_min] = temp
    end
  end
  return array
  # puts "NOT IMPLEMENTED"
end

# Restricted arrays cannot be resized. So, we follow a convention.
# Convention: change the value to be deleted with 'SPECIAL_VALUE'
# Deletes 'value_to_delete' if found in the array. To keep the array size
# constant, adds an element with 'SPECIAL_VALUE' in the end. Assumes the array
# to be sorted in ascending order.
def delete(array, length, value_to_delete)
  # assume array sorted in ascending order
  if !search(array, length, value_to_delete)
    return "Value to delete not found"
  end

  index = search_sorted(array, 0, (length-1), value_to_delete)

  #Find lowes index for space with value = value_to_delete
  ind = index-1
  until array[ind] != value_to_delete || ind < 0
    index = ind
    ind -= 1
  end

  # Find index for duplicates of value_to_delete
  ind = index + 1
  count = 1
  until array[ind] != value_to_delete
    count += 1
    ind += 1
  end

  # Rearrange values in the array to fill the deleted position
  for ind in index...length-count
    array[ind] = array[ind+count]
  end

  # Add the SPECIAL_VALUE to fill the empty spaces at the end of the array
  for ind in length-count...length
    array[ind] = SPECIAL_VALUE
  end

  # return the array
  return array
  # puts "NOT IMPLEMENTED"
end

# Restricted array cannot be resized. So, we workaround by having a convention
# Convention: replace all values with 'SPECIAL_VALUE'
# Empties the restricted array by making all values = SPECIAL_VALUE
def empty(array, length)
  index = 0
  until array[index] == nil
    array[index] = SPECIAL_VALUE
    index += 1
  end
  return array
  # puts "NOT IMPLEMENTED"
end

# Finds and returns the largest value element in the array which is not 'SPECIAL_VALUE'
# Assumes that the array is not sorted.
def find_largest(array, length)
  ind_max = 0
  max = array[ind_max]
  for ind in 0...length
    if array[ind] > max
      ind_max = ind
      max = array[ind]
    end
  end
  return max
  # puts "NOT IMPLEMENTED"
end

# Insert value to insert at the correct index into the array assuming the array
# is sorted in ascending manner.
# Restricted arrays cannot be resized. Insert only if there is space in the array.
# (Hint: if there are elements with 'SPECIAL_VALUE', there is no room to insert)
# All subsequent elements will need to be moved forward by one index.
def insert_ascending(array, length, value_to_insert)
  #check if there is space in the array
  if array[length-1] != SPECIAL_VALUE
    return 'No space in the array to insert a value'
  end

  index = 0
  until array[index] > value_to_insert
    index += 1
  end

  j = length - 1
  until j == index
    array[j] = array[j-1]
    j -= 1
  end
  array[index] = value_to_insert
  return array
  # puts "NOT IMPLEMENTED"
end

## --- END OF METHODS ---

# A restricted array could be constructed of a given size like so
size = 5
my_integer_array = RestrictedArray.new(size)
my_integer_array_length = length(my_integer_array)
puts "The length of my integer array is #{my_integer_array_length}, which should be the same as #{size}."
puts "BUG!" if my_integer_array_length != size
puts

# A restricted array could be constructed of a random size (1 to 20) like so
another_array = RestrictedArray.new()
another_array_length = length(another_array)
puts "The length of my random length, integer array is #{another_array_length}."
puts

# print the current array
print "Printing values in the array: "
print_array(another_array)
# reverse the values in the current array
reverse(another_array, another_array_length)
# prints the reversed array
print "Reversed array: "
print_array(another_array)
puts

# search for value_to_find in the array
value_to_find = 120
if search(another_array, another_array_length, value_to_find)
  puts "#{value_to_find} found in the array!"
else
  puts "#{value_to_find} not found in the array!"
end
puts

# search for value_to_find in the array - find the last value
value_to_find = another_array[another_array_length-1]
if search(another_array, another_array_length, value_to_find)
  puts "#{value_to_find} found in the array!"
else
  puts "#{value_to_find} not found in the array!"
  puts "BUG! #{value_to_find} should be at index #{another_array_length-1}"
end
puts

# print the largest value in the array
largest = find_largest(another_array, another_array_length)
puts "The largest value in the array is #{largest}"
puts

# sort the array
sort(another_array, another_array_length)
print "Array sorted in ascending order: "
print_array(another_array)
puts

# delete the first entry with the value_to_delete
value_to_delete = another_array[another_array_length/2]
delete(another_array, another_array_length, value_to_delete)
print "#{value_to_delete} deleted from array: "
print_array(another_array)
puts

# delete the first entry with the value_to_delete
value_to_delete = another_array[another_array_length/2]
delete(another_array, another_array_length, value_to_delete)
print "#{value_to_delete} deleted from array: "
print_array(another_array)
puts

# print the largest value in the array
largest = find_largest(another_array, another_array_length)
puts "The largest value in the array is #{largest}"
puts

# sort the array
sort(another_array, another_array_length)
print "Array sorted in ascending order: "
print_array(another_array)
puts

# insert 123 in to the array sorted in ascending order
value_to_insert = 123
insert_ascending(another_array, another_array_length, value_to_insert)
print "#{value_to_insert} inserted into the array: "
print_array(another_array)
puts

# empty array
empty(another_array, another_array_length)
print "Emptied array looks like: "
print_array(another_array)
puts

# insert 123 in to the array sorted in ascending order
value_to_insert = 123
insert_ascending(another_array, another_array_length, value_to_insert)
print "#{value_to_insert} inserted into the array: "
print_array(another_array)
puts
