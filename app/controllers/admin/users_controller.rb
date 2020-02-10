module Admin
  class UsersController < AdminController
    
    def index
      @users = User.includes(:transcriptions).order('admin desc, created_at asc')
    end

    def show
      @user = User.includes(
        {
          transcriptions: [
            { 
              page: [
                :page_days,
		:page_info
              ] 
            },
            :annotations
          ]
        },
        :data_entries
      ).find params[:id]
    end

    def edit
      @user = User.find params[:id]
    end

    def update
      begin
        User.transaction do
          @user = User.find params[:id]
          @user.update_attributes(users_params)
        end
      rescue => e
        flash[:danger] = e.message
      end

      respond_to do |format|
        format.html { redirect_to admin_users_path }
      end
    end
    
    def destroy
      begin
        User.transaction do
          @user = User.find(params[:id])
          @user.destroy
        end
      rescue => e
        flash[:danger] = e.message
      end

      respond_to do |format|
        format.html { redirect_to admin_users_path }
      end
    end

    private

    def users_params
      params.require(:user).permit(:display_name, :admin, :bio)
    end

  end
end
