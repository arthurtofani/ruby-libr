module Recipe		
	processor_dict = {}
	default_processor = nil
	runtime_method = :html

	def set_default_processor(proc_class)
		default_processor = proc_class
	end

	def set_method(mtd)
		runtime_method = mtd
	end

	def set_processor(xmlns, proc_class)
		processor_dict[xmlns] = proc_class
	end

end
