class AdminController < ApplicationController
	def index
		@all_data =  EventTransaction.select('pay_id','created_at','user_id').group('pay_id')
		puts @all_data.inspect
		puts "============="
		if session[:user_id]
	      @current_user = User.find(session["user_id"])
	    else
	      @current_user = nil
	    end
	    if session[:user_id]
	      @current_user = User.find(session["user_id"])
	    else
	      @current_user = nil
	    end
		render :layout => false
	end

	def transaction_detail
		@hotels = HotelTransaction.where(:pay_id => params[:pay_id])
      	@events = EventTransaction.where(:pay_id => params[:pay_id])
		if session[:user_id]
	      @current_user = User.find(session["user_id"])
	    else
	      @current_user = nil
	    end
	    if session[:user_id]
	      @current_user = User.find(session["user_id"])
	    else
	      @current_user = nil
	    end
		render :layout => false
	end

	# def index_ajax
	# 	start =  (params[:start]).to_i
	# 	length = (params[:length]).to_i
	# 	all_data = User.all
	# 	# all_data = Review.select('reviews.id,reviews.comment,reviews.rating,profiles.first_name,profiles.last_name,wineries.name as winery_name').joins(user: :profile).joins(:winery)
	# 	puts "===="
	# 	puts all_data[0].inspect
	# 	puts all_data[0].id
	# 	puts "===="
	# 	all_count = all_data.length
	# 	puts all_count
	# 	puts "---------"
	# 	if not params[:search]['value'].blank?
	# 		puts "in search"
	# 		searchText = ((params[:search]['value'].to_s).downcase).strip
	# 		print searchText

	# 		all_data = all_data.where("lower(email) LIKE :search or lower(first_name) LIKE :search or lower(last_name) LIKE :search " , :search => "%"+searchText+"%")
	# 		# all_data = all_data.where("lower(comment) LIKE :search or rating::text LIKE :search or lower(first_name) LIKE :search or lower(last_name) LIKE :search or lower(wineries.name) LIKE :search " , :search => "%"+searchText+"%")

	# 	end

	# 	result = all_data
	# 	filer_count = result.length

	# 	if params[:order]['0']['column'] == "0"
	# 		if  params[:order]['0']['dir'] == "asc"
	# 			result = all_data.order('id asc').limit(length).offset(start)
	# 		else
	# 			result = all_data.order('id desc').limit(length).offset(start)
	# 		end
	# 	elsif params[:order]['0']['column'] == "1"
	# 		if params[:order]['0']['dir'] == "asc"
	# 			result = all_data.order('first_name asc').limit(length).offset(start)
	# 		else
	# 			result = all_data.order('first_name desc').limit(length).offset(start)
	# 		end
	# 	elsif params[:order]['0']['column'] == "2"
	# 		if params[:order]['0']['dir'] == "asc"
	# 			result = all_data.order('email asc').limit(length).offset(start)
	# 		else
	# 			result = all_data.order('email desc').limit(length).offset(start)
	# 		end
		
	# 	else
	# 	 	result = all_data.limit(length).offset(start)
	# 	end

	# 	data=[]
	# 	for i in result
	# 		data1=[]
	# 		data1.append(i['id'])
	# 		data1.append(i['first_name']+" "+i['last_name'])
	# 		data1.append(i['email'])
			
	# 		data1.append('<a href="/admin/user/show/'+i['id'].to_s+'">
	# 			<button class="btn btn-primary" type="button">
	# 				Show Transactions
	# 			</button>
	# 		</a>')
	# 		data.append(data1)
	# 	end
	# 	msg = {'data': data,'draw': params[:draw],'recordsTotal': all_count,'recordsFiltered': filer_count}

	# 	respond_to do |format|
	#       format.json { render json: msg }
	#     end
	# end



end
