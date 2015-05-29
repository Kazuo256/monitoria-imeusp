class AssistantFrequencyController < ApplicationController
 
  def request_frequency
    professors = []
    semester = Semester.current
    requests = RequestForTeachingAssistant.where(semester: semester)
    AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
      professors.push(assistant.professor)
    end
    professors.uniq.each do |professor|   
      NotificationMailer.frequency_request_notification(professor).deliver      
    end
    Delayed::Job.enqueue(FrequencyMailJob.new, 0, 3.days.from_now.getutc)
    respond_to do |format|
      format.html { redirect_to '/assistant_roles', notice: 'Pedidos enviados com sucesso.' }      
    end
  end

  def mark_assistant_role_frequency
    presence = params[:presence]
    month = params[:month]
    role = params[:role]
    id = params[:pid]
    red_path = '/assistant_roles/for_professor/'+id
    if id.to_i < 0
      red_path = '/assistant_roles'
    end
    @assistant_frequency = AssistantFrequency.new(month: month, presence: presence, assistant_role_id: role)
    if @assistant_frequency.save
      if presence
        respond_to do |format|
          format.html { redirect_to red_path, notice: 'Presença marcada com sucesso.' }      
        end
      else 
        respond_to do |format|
          format.html { redirect_to red_path, notice: 'Ausência marcada com sucesso.' }      
        end
      end
    else
        respond_to do |format|
          format.html { redirect_to red_path, notice: 'Erro ao marcar frequência.' }      
        end      
    end
  end
end
