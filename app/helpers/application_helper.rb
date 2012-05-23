# encoding: utf-8

module ApplicationHelper

	def monthsForSelect
		#return select_month(Date.today, :use_month_names => %w(Január Február Március Április Május Június Július Augusztus Szeptember Október November December))
		return month = [['Január', 1],['Február', 2],['Március', 3],['Április', 4],['Május', 5],['Június', 6],['Július', 7],['Augusztus', 8],['Szeptember', 9],['Október', 10],['November', 11],['December', 12]]
	end

	def periodsForSelect
		return period = [['Tavaszi szünet', 13],['Nyáron', 14]]
	end

end
