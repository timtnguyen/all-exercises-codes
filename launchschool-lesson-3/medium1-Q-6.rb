def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

p rolling_buffer1(5, 3, 4)

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

# In the first method, the imput argument called buffer will be modified
# and will end up being changed after method return. The second one will
# not alter the caller's input argument
