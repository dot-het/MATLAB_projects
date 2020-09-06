%   GUI
function analysis()

    %   Setting up the main panel
    %   Positions are in pixels
    Panel = figure('Visible','on', 'Name','N-back', 'Menubar','none', 'NumberTitle','off', 'Position',[250,150,1400,800]);
        
        %   Game - N_back generate
        %   Positions are propotions - are always proportional for the previous panel 
        Game_name = uicontrol(Panel,'Style','text','String','N-back',...
                'Units','normalized','Position',[1/12 11/12 2.7/12 1/12], 'Fontsize', 45);
            
        %   N-back input files
        Input_file_step_size_Text = uicontrol(Panel,'Style','text','String','Input file participant number:',...
                'Units','normalized','Position',[9.5/12 11/12 2/12 0.8/12]);

        Container.Input_file_step_size_Textbox = uicontrol(Panel,'Style','edit', 'String','01',...
                'Units','normalized','Position',[9.5/12 11.2/12 2/12 0.3/12]);
            
        %   Container for the starter menu
        Menu = uipanel('Parent',Panel,'Title','Menu','Units','normalized','Position',[0.01 0.1 0.35 0.8]);
    
            %   Items in the CONTAINER
            
            %   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %   Items for the starter panel
            
            Description_label = uicontrol(Menu,'Style','text','String','Description:',...
                'Units','normalized','Position',[1/12 10.5/12 10/12 1/12]);

            Description = uicontrol(Menu,'Style','text','String','This is an N-back program. The subject is presented with a sequence of stimuli, and the task consists of indicating when the current stimulus matches the one from n (It can be set by Step size) steps earlier in the sequence. The user task to decide that current phrase match with previous "n" phrase or not',...
                'Units','normalized','Position',[0/12 9/12 12/12 2/12]);

            Guide = uicontrol(Menu,'Style','text','String','                       If you are right-handed please press "k" for targets or "j" for non-targets.                      If you are left-handed please press "d" for targets or "f" for non-targets.',...
                'Units','normalized','Position',[0/12 7/12 12/12 2/12]);

            %   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          
            %   Step size
            
            Container.Step_size_Text = uicontrol(Menu,'Style','text','String','Step size:',...
                'Units','normalized','Position',[1/12 6/12 10/12 1/12]);

            Container.Step_size_Textbox = uicontrol(Menu,'Style','edit', 'String','1',...
                'Units','normalized','Position',[1/12 6/12 10/12 0.6/12]);

            %   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           
            %   Sequence
            Container.Sequence_size_Text = uicontrol(Menu,'Style','text','String','Length of sequence:',...
                'Units','normalized','Position',[1/12 4.5/12 10/12 1/12]);

            Container.Sequence_size_Textbox = uicontrol(Menu,'Style','edit', 'String','48',...
                'Units','normalized','Position',[1/12 4.5/12 10/12 0.6/12]);
            
            %   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           
            %   Play Button
            Container.Confirm_settings_Button = uicontrol(Menu,'Style','pushbutton','String','Play',...
                'Units','normalized','Position',[1/12 2.5/12 10/12 0.1], 'Callback',@Confirm_settings);
            
            %   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          
            %   File name
            Container.File_name_Text = uicontrol(Menu,'Style','text','String','File name where store the results:',...
                'Units','normalized','Position',[1/12 1/12 10/12 1/12]);

            Container.File_name_Textbox = uicontrol(Menu,'Style','edit', 'String','participant_01_1_back',...
                'Units','normalized','Position',[1/12 1/12 10/12 0.6/12]);

            %   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         
            %   Display unit
            Container.Next_character = uicontrol(Menu,'Style','text','String','', 'Visible','off',...
                'Units','normalized','Position',[1/12 1/12 10/12 4/12], 'Fontsize', 65);
            
        %   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        %   Read the files
        
            Container.Read_files_Button = uicontrol(Panel,'Style','pushbutton','String','Display results',...
                'Units','normalized','Position', [5/12 11/12 4/12 0.07], 'Callback',@Read_files);
            
        %   Locate the axes for the plots
        
        Container.ax_histogram_1 = axes( 'position', [.39 .68 .25 .2], 'box', 'on', 'Visible', 'on' );
        Container.ax_histogram_2 = axes( 'position', [.7 .68 .25 .2], 'box', 'on', 'Visible', 'on' );
        Container.ax_histogram_3 = axes( 'position', [.39 .41 .25 .2], 'box', 'on', 'Visible', 'on' );
        Container.ax_histogram_4 = axes( 'position', [.7 .41 .25 .2], 'box', 'on', 'Visible', 'on' );
        
        Container.ax_bar_1 = axes( 'position', [.39 .05 .18 .3], 'box', 'on', 'Visible', 'on' );
        Container.ax_bar_2 = axes( 'position', [.6 .05 .18 .3], 'box', 'on', 'Visible', 'on' );
        Container.ax_bar_3 = axes( 'position', [.81 .05 .18 .3], 'box', 'on', 'Visible', 'on' );
        
        %   Store container settings
        
        assignin('base','Container',Container);
end

function Confirm_settings(~, ~)
    %  Get container    
    %  Calling the function of the first button inputs
    %  Read back the stored variables
    
    Container = evalin('base', 'Container');
    
    %   Clear callback function
    %   Security function - prevent other buttons operation (if they are
    %   pressed)
    
    set(Container.Read_files_Button, 'Callback', '');
    
    %   Error check
    %   Checking inputs are valid for the conditions
    try
        N = str2double(get(Container.Step_size_Textbox, 'String'));
        n_presentations = str2double(get(Container.Sequence_size_Textbox, 'String'));
        
        if ( N < 1 || n_presentations < 2 || N > 4 || n_presentations > 48 )
            throw(ME)
        end
        
        %   Warning the user
        %   If the length of the sequence are not 24 or 48
        
        if  ( N == 1 || N == 2  && n_presentations ~= 24 || n_presentations ~=48 ) 
            temp_choice = questdlg('The basic length of the sequence for the practice mode is 24, otherwise the length of the sequence for 1 or 2 step size is 48. Do you want to keep the step size what you defined?', ['Warning'], 'Yes', 'No', 'Yes');
            if isequal( temp_choice, 'No' )
                n_presentations = 24;
            end
        end
        if ( ( N == 3 || N == 4 ) && n_presentations ~= 48 )
            temp_choice = questdlg('The basic length of the sequence for 3 or 4 step size is 48. Do you want to keep the step size what you defined?', ['Warning'], 'Yes', 'No', 'Yes');
            if isequal( temp_choice, 'No' )
                n_presentations = 48;
            end
        end
        
        %   If error is detected
        
    catch
        choice = questdlg('Wrong inputs, give other values', ['Error'], 'Ok','Ok');
        return;
    end
    
    %   Hide menu
    %   Hide the "unnecessary" items during the sequence presentation
    
    set(Container.Step_size_Text, 'Visible', 'off');
    set(Container.Step_size_Textbox, 'Visible', 'off');
    set(Container.Sequence_size_Text, 'Visible', 'off');
    set(Container.Sequence_size_Textbox, 'Visible', 'off');
    set(Container.Confirm_settings_Button, 'Visible', 'off');
    set(Container.File_name_Text, 'Visible', 'off');
    set(Container.File_name_Textbox, 'Visible', 'off');
    
	%	Generate sequence
    
    sequence = generate_sequence ( N, n_presentations );
    
	%	Main process
    
    [rts, responses] = deliver_n_back(sequence);
    
    %   Handle the quit command
    
    if ( isequal ( get( Container.Next_character, 'Visible' ), 'on' ) )
      
        %   Reset menu
        %   If the quit command come into force, change the menu 
        %   Show the menu panel
        
        set(Container.Next_character, 'Visible', 'off');
        set(Container.Step_size_Text, 'Visible', 'on');
        set(Container.Step_size_Textbox, 'Visible', 'on');
        set(Container.Sequence_size_Text, 'Visible', 'on');
        set(Container.Sequence_size_Textbox, 'Visible', 'on');
        set(Container.Confirm_settings_Button, 'Visible', 'on');
        set(Container.File_name_Text, 'Visible', 'on');
        set(Container.File_name_Textbox, 'Visible', 'on');
        set(Container.Read_files_Button, 'Callback', @Read_files);
        return
    end
    
    %   Reset menu
    
    set(Container.Step_size_Text, 'Visible', 'on');
    set(Container.Step_size_Textbox, 'Visible', 'on');
    set(Container.Sequence_size_Text, 'Visible', 'on');
    set(Container.Sequence_size_Textbox, 'Visible', 'on');
    set(Container.Confirm_settings_Button, 'Visible', 'on');
    set(Container.File_name_Text, 'Visible', 'on');
    set(Container.File_name_Textbox, 'Visible', 'on');
    
	%	Save results
    
    filename = get(Container.File_name_Textbox, 'String');
    save_run(filename, sequence, rts, responses)

    
	%	Display variables on workspace	(for debug)
    
    assignin('base','sequence',sequence);
    assignin('base','rts',rts);
    assignin('base','responses',responses);
    
    %   Restore callback fcn
    %   For allowing other buttons operation
    
    set(Container.Read_files_Button, 'Callback', @Read_files);
    
    
end

function sequence = generate_sequence(N, n_presentations)
         available_characters = 'BCDFGHJKLMNPQRSTVWXYZ';
                 
    for i = 1 : n_presentations
        if ( i - N > 0 )
			%	
            %   Generate sequence with the 33.3% probability of the target
			%	letters and ensure that the first N letters can not be tartget.
            %
            %   Generate a variable (temp) that contains randomly ordered elements
            %   of 1 or 2 or 3.
            %   IF the variable temp is equal to one: 
            %       the letter in the first column of the sequence is the same 
            %       as the previous one and
            %       fill the second column of the sequence with 'T'
            %   
            %
            temp = randi(3);
            if ( temp == 1 )
                sequence(i, 1) = sequence(i-N, 1);
                sequence(i, 2) = 'T';
            else
                %   Remove N-back characters from the available characters:
                %
                %   If temp is not equal to 1, delete all the letters with N-back
                %   Filled the first column with randomly ordered letters of the temporary characters 
                %   filled with 'N' as non-target in the second column of sequence   
                
                temp_available_characters = regexprep(available_characters, sequence(i-N, 1), '');
                sequence(i, 1) = temp_available_characters(randi(numel(temp_available_characters)));
                sequence(i, 2) = 'N';
            end
        else
			%	Generate first N character:
            %
            %   Fill the first column with N randomly ordered letters and the
            %   second column with N 'N' if the condition is not trure (i-N>0)
            %   
            sequence(i, 1) = available_characters(randi(numel(available_characters)));
            sequence(i, 2) = 'N';
        end
    end
end

function [rts, responses] = deliver_n_back(sequence)
	%	Define necessary variables
    rts = 0;
    responses = '0';
    f = figure('Position', [1 1 200 200], 'Visible', 'off', 'Tag', 'hehehe', 'Visible', 'on', 'Menubar','none');

    Container = evalin('base', 'Container');    % call back stored variables
    time_limit = 2;                             % define the time limit (2sec)
    set(f,'KeyPressFcn',@KeyPressFcnCbk);       % create a new "function" for keyboard responses
    
    for i = 1 : length(sequence)
        %   Reset check values
        check_key_press = NaN;      
        first_inp = 0;              % security variable - avoid overwriting the reponse 
                                    % that was give within the time limit
        drawnow                     % refresh GUI
        
        %   Reset settings
        %   Present the first character
        set(Container.Next_character, 'Visible', 'on', 'String', sequence(i, 1));
        tic;                        % start the stopwatch for reaction time
        
        %   Process
        %   
        while( toc <= time_limit )              % stop stopwatch
            if ( ~isnan(check_key_press) )      % check_key_press stored the responses
                % Quit command
                if ( check_key_press == '0' )   % quit command, if the input is q 
                    delete(f)                   % delete the figure f
                    return
                end
                %   Condition
                if ( first_inp == 0 )           % if first input is not empty (not NaN)
                    rts(i) = round(toc*1000);   % store reaction time in milisec
                    responses(i) = check_key_press;     % store responses 
                    first_inp = 1;              % avoid another keyreponses (mistyped/pressed keyboards)
                end                             % if the first has been already stored
            end
            drawnow                            %  refresh GUI (reaction times)
        end
        
        %   If there was no answer
        if ( isnan(check_key_press) )
            responses(i) = '0';                %  store 0 for response
            rts(i) = 0;                        %  store 0 for reaction time
        end
        
        %   Hide values, delay
        set(Container.Next_character, 'Visible', 'off');    % Hide sequence elements after 2 sec
        pause(0.5)                                          % Wait 0.5 sec for the next elements
    end
    
    %   Nested Key Press Function
    function KeyPressFcnCbk(~,eventdata)                    % Function for the responses
        try                                                 % Keyboards responses
            strngKey = eventdata.Key;
            
            switch strngKey
                case {'j'}
                    check_key_press = 'N';
                case {'k'}
                    check_key_press = 'T';
                case {'d'}
                    check_key_press = 'T';
                case {'f'}
                    check_key_press = 'N';
                case {'q'}
                    check_key_press = '0';
                otherwise
                    check_key_press = NaN;                 % if other keyboards were pressed than (j,k,d,g,q) store NaN
            end
        catch exc2
            disp('error in keypress callback')
            rethrow(exc2)
        end
    end

    delete(f)           % delete the created figures (no need more)
end

function save_run(filename, sequence, rts, responses)
	%	Open file
    %   Save the responses of the participants in csv file format
    %   1st column: the 1st column of sequence (letters) - string
    %   2nd column: the 2nd column of sequence (T/N) - string
    %   3rd column: the reaction times of the partcipants - integer
    %   4th column: answers of the participants - character
	fileID = fopen( strcat ( filename, '.csv' ),'w');
    for i = 1 : length(sequence)
        fprintf(fileID, '%s, %s, %d, %c\n', sequence(i, 1), sequence(i, 2), rts(i), responses(i));
    end
	fclose(fileID);
end

function Read_files(~, ~)             % Called function for reading files in the beginning of analysis.m 
    Container = evalin('base', 'Container');
    
    %   Get participant ID
    N = get(Container.Input_file_step_size_Textbox, 'String');

    %   Select files location
    temp_path = uigetdir;
    
    %	Search and remove unnecessary items
    filename = dir(temp_path);
    filename(ismember( {filename.name}, {'.', '..'})) = [];
    
    fig = analyze_n_back(filename, N);
end

function [fig] = analyze_n_back(filename, N)
    Container = evalin('base', 'Container');
    
    %   Participant name
    N_modified = strcat('participant_', N);
    
    %   Identify false files
    for i = 1 : length(filename)
        try
            temp_string = filename(i).name(1:14);
        catch
            temp_string = 'error';
        end
        %   If participant's filename and the given name are not the same
        %   give and error
        if ( ~isequal( temp_string, N_modified ))
            filename(i).name = '.';
        end
    end
    
    %   Delete false files
    filename(ismember( {filename.name}, {'.'})) = [];
    
    %   Read files
    %   
    %   Read files (1back, 2back, 3back, 4back of one participant) into table, 
    %   convert them to cell format without using header
    try
        temp_array1 = table2cell( readtable( filename(1).name, 'ReadVariableNames', false ) );
        temp_array2 = table2cell( readtable( filename(2).name, 'ReadVariableNames', false ) );
        temp_array3 = table2cell( readtable( filename(3).name, 'ReadVariableNames', false ) );
        temp_array4 = table2cell( readtable( filename(4).name, 'ReadVariableNames', false ) );
    catch
        
    %   Warning the user, all the n-backs are needed, for the analysis
   
        dummy = questdlg('Every results of the participant is needed. Please generate them!', ['Warning'], 'Ok', 'Ok');
        return
    end
    
    %   Delete the first N rows from the arrays
 
    
    temp_array1 = N_back_calculator(temp_array1);
    temp_array2 = N_back_calculator(temp_array2);
    temp_array3 = N_back_calculator(temp_array3);
    temp_array4 = N_back_calculator(temp_array4);
    
    %   Histograms:
    
    %   Histograms of the reaction time distribution
    %   1back, 2back, 3back and 4back
    
    histogram_1_result = temp_array1( ismember( cell2mat( temp_array1( :, 5 ) ), 1 ), 3 );
    histogram_2_result = temp_array2( ismember( cell2mat( temp_array2( :, 5 ) ), 1 ), 3 );
    histogram_3_result = temp_array3( ismember( cell2mat( temp_array3( :, 5 ) ), 1 ), 3 );
    histogram_4_result = temp_array4( ismember( cell2mat( temp_array4( :, 5 ) ), 1 ), 3 );
    
    Resolution = 15;
    histogram(Container.ax_histogram_1, cell2mat( histogram_1_result ), Resolution);
    histogram(Container.ax_histogram_2, cell2mat( histogram_2_result ), Resolution);
    histogram(Container.ax_histogram_3, cell2mat( histogram_3_result ), Resolution);
    histogram(Container.ax_histogram_4, cell2mat( histogram_4_result ), Resolution);
    
    title(Container.ax_histogram_1, 'Reaction time distribution 1');
    title(Container.ax_histogram_2, 'Reaction time distribution 2');
    title(Container.ax_histogram_3, 'Reaction time distribution 3');
    title(Container.ax_histogram_4, 'Reaction time distribution 4');
    
    %   Mean of the reaction times for correct responses to targets:
    %   On the figure there are the means of the reaction times for all
    %   versions of the tasks / participant
    
    Character_checker = 'T';
    bar_1_result(1, 1) = mean_calculator(temp_array1, Character_checker);
    bar_1_result(2, 1) = mean_calculator(temp_array2, Character_checker);
    bar_1_result(3, 1) = mean_calculator(temp_array3, Character_checker);
    bar_1_result(4, 1) = mean_calculator(temp_array4, Character_checker);
    
    bar(Container.ax_bar_1, bar_1_result);
    title(Container.ax_bar_1, 'Mean reaction time to targets');
    
    %   Mean of the reaction times for correct responses to non-targets:
    %   On the figure there are the means of the reaction times
    %   (non-targets) for all versions of the tasks / participant
    
    Character_checker = 'N';
    bar_2_result(1, 1) = mean_calculator(temp_array1, Character_checker);
    bar_2_result(2, 1) = mean_calculator(temp_array2, Character_checker);
    bar_2_result(3, 1) = mean_calculator(temp_array3, Character_checker);
    bar_2_result(4, 1) = mean_calculator(temp_array4, Character_checker);
    
    bar(Container.ax_bar_2, bar_2_result);
    title(Container.ax_bar_2, 'Mean reaction time to non-targets');
    
    %   Percentages of the correct answers bar chart
    %   Using the basic equation of the percentage calculation
        
    bar_3_result(1, 1) = round ( sum( cell2mat( temp_array1( :, 5 ) ) ) / length(temp_array1) * 100 );
    bar_3_result(2, 1) = round ( sum( cell2mat( temp_array2( :, 5 ) ) ) / length(temp_array2) * 100 );
    bar_3_result(3, 1) = round ( sum( cell2mat( temp_array3( :, 5 ) ) ) / length(temp_array3) * 100 );
    bar_3_result(4, 1) = round ( sum( cell2mat( temp_array4( :, 5 ) ) ) / length(temp_array4) * 100 );
    
    bar(Container.ax_bar_3, bar_3_result);
    title('Percent correction');
    
        
   
    fig = 0;
end

function [temp_array] = N_back_calculator(temp_array)       % Delete the N-back arrays from temp_arrays 
    for i = 1 : length(temp_array)                          % to avoid the analysis of the first N rows
        if( isequal( char( temp_array( i, 2 ) ), 'T' ) )    % Calculating the N-back size (1,2,3,4)
            for j = i-1 : -1 : 1
                if( isequal( char( temp_array( i, 1 ) ), char( temp_array( j, 1 ) ) ) )
                    N_back_size = i - j;
                    break;                                  % If the 'T' is found stop and delete the first N rows
                end
            end
            break;
        end
    end
    
    try
        temp_array( 1 : N_back_size, : ) = [];
    catch
        %   Do nothing
    end
    
    
    %   Find right answers:
    
    %   If the elements of the 2nd (the 2nd column of the sequence = original T/N signs)
    %   and the 4th column (the participants responses) are the same
    %   Create a new column (temp_array 5)--> using 1
    %   If they are not the same --> using 0
    
    for i = 1 : length(temp_array)
        if( isequal( char( temp_array( i, 2 ) ), char( temp_array( i, 4 ) ) ) )
            temp_array( i, 5 ) = num2cell(1);
        else
            temp_array( i, 5 ) = num2cell(0);
        end
    end
end

%   Calculating the means for the correctly answersed targets:

%   Using bar chart for representing the result
%   If the elements of the 2nd (the 2nd column of the sequence = original T/N signs)
%   and the 5th column of temparray (the freshly generated column of the
%   correct answers (1)-->convert them to matrix form from cell to have the
%   proper format for further steps
%   Generate new matrix --> 1st column filled with the correctly answered
%   reaction times for target or non-targets (depends on the
%   Character_checker (N/T)
%   Calculate the mean

function [bar_2_result] = mean_calculator(temp_array, Character_checker)
    for i = 1 : length(temp_array)
        if ( isequal( char ( temp_array( i, 2 ) ), Character_checker ) && isequal( cell2mat ( temp_array( i, 5 ) ), 1 ) )
            temp_counter( i, 1 ) = cell2mat( temp_array( i, 3 ) );
        end
    end
    
    temp_counter( ismember( temp_counter, 0 ) ) = [];
    bar_2_result = sum( temp_counter( : ) ) / length(temp_counter);
end
