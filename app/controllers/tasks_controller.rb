class TasksController < ApplicationController
	def create
		@project = Project.find(params[:project_id])
		@task = @project.tasks.create(task_params)
		redirect_to user_project_path(user_params[:user_id] , @project.id)
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to user_project_path(params[:user_id], params[:project_id])
	end


	private

	def task_params
		params[:task].permit(:title, :contributor, :time)
	end

	def user_params
		params[:task].permit(:user_id)
	end
end
