class AbstractsController < ApplicationController
  skip_before_filter :login_required, :only => [ :index, :show ]

  # GET /abstracts
  # GET /abstracts.xml
  def index
	  session[:where_from] = 'abstract'
	  if params[:user_id]
      @abstracts = Abstract.find(:all, :conditions =>['user_id = :user_id',
        {:user_id => params[:user_id] } ])
    else
      @abstracts = Abstract.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @abstracts }
      format.csv {

        buffer = FasterCSV.generate do |csv|
          fields = [
            :user_id,
            :title,
            :authors,
            :address,
            :presenter,
            :abstract_type,
            :abstract,
            :agreement,
            :note_to_organizers,
            :created_at,
            :updated_at
          ]
          csv << fields.map{|field| field.to_s}
          for abstract in @abstracts
            csv << fields.map{|field| value = abstract.send(field)}
          end
        end
        send_data( buffer, :type => 'text/csv; charset=iso-8859-1; header=present', :filename => 'abstracts.csv')
      }
    end
  end

  # GET /abstracts/1
  # GET /abstracts/1.xml
  def show
    @abstract = Abstract.find(params[:id])
	#@abstract = Abstract.where(:user_id => current_user.id).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @abstract }
    end
  end

  # GET /abstracts/new
  # GET /abstracts/new.xml
  def new
    @abstract = Abstract.new( :user_id=>current_user.id )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @abstract }
    end
  end

  # GET /abstracts/1/edit
  def edit
    @abstract = Abstract.find(params[:id])
  end

  # POST /abstracts
  # POST /abstracts.xml
  def create
    @abstract = Abstract.new(params[:abstract])

    respond_to do |format|
      if @abstract.save
        format.html { redirect_to(@abstract, :notice => 'Abstract was successfully created.') }
        format.xml  { render :xml => @abstract, :status => :created, :location => @abstract }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @abstract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /abstracts/1
  # PUT /abstracts/1.xml
  def update
    @abstract = Abstract.find(params[:id])

    respond_to do |format|
      if @abstract.update_attributes(params[:abstract])
        format.html { redirect_to(@abstract, :notice => 'Abstract was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @abstract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /abstracts/1
  # DELETE /abstracts/1.xml
  def destroy
    @abstract = Abstract.find(params[:id])
    @abstract.destroy

    respond_to do |format|
      format.html { redirect_to(abstracts_url) }
      format.xml  { head :ok }
    end
  end
end
