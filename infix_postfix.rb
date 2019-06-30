def infix_to_postfix(expression)
	operands = {'+'=>1, '-'=>1, '*'=>2,'/'=>2}
	compute_stack = []
	operand_stack = []
	
	tokenized_expression = expression.gsub(" ", "").split(/(\d+\.?\d*)/).reject(&:empty?)
  
	puts 'infix:' + tokenized_expression.to_s
  
	tokenized_expression.each do |char|
		compute_stack.push(char) if char =~ /[[:digit:]]/
		if operands.include?(char)
			while operands[operand_stack.last] && operands[operand_stack.last] >= operands[char]
				compute_stack.push(operand_stack.pop)
			end
			operand_stack.push(char) 
		end		
	end
	while operand_stack.length > 0
		compute_stack << operand_stack.pop
	end
	return compute_stack
end

def compute(exp)
	compute_stack = infix_to_postfix(exp)
	puts "postfix: " + compute_stack.to_s
	numbers = []
	compute_stack.each do | symbol |
		if symbol =~ /[[:digit:]]/
			numbers << symbol 
		else
			right_num = numbers.pop
			left_num  = numbers.pop
			result = evaluate(right_num.to_i, left_num.to_i, symbol)
			numbers << result
		end
	end
	return numbers.last
end

def evaluate(right_num, left_num, operation)
	case operation
		when '+' then left_num + right_num
		when '-' then left_num - right_num
		when '*' then left_num * right_num
		when '/' then left_num / right_num
	end
end

#10
exp = "2 * 4 + 2"
puts compute(exp)

#16
puts compute("10+3-6/2+2*3")