uses crt,dos;
var a:array[1..10000] of word;
    st:string;
    filename,filename1:string;
    f:text;
    i,i1,n,k,m,m1,x,y,BPM:byte;
    ch,ch1,ch2:char;
    chk:boolean;
    st1,st2:word;
procedure readfile;
var dirinfo:searchrec;
    c,i,b:byte;
    x:array[1..247] of string;
    ch3:char;
begin
{$S-}
     c:=1;b:=1;ch3:=#0;
     clrscr;
     findfirst('*.*',archive,dirinfo);
     while (doserror=0) and (c<248) do
     begin
          x[c]:=dirinfo.name;
          c:=c+1;
          findnext(dirinfo);
     end;
     c:=c-1;
     if c>24 then
        while ch3<>chr(27) do
        begin
             clrscr;
             for i:=b to b+y-2 do
                 writeln(x[i]);
             ch3:=readkey;
             if (ch3=#72) and (b>=1) then b:=b-1;
             if (ch3=#80) and (b+y-2<=c) then b:=b+1;
             if b=0 then b:=c-y+2;
             if b=c-y+3 then b:=1;
        end;
     if c<=y-1 then
        for i:=1 to n do
            writeln(x[i]);
end;
function checkfile(filename:string):boolean;
var f:text;
        c:boolean;
begin
{$I-}
     assign(f,filename);
     reset(f);
     if IOResult=0 then c:=true
     else c:=false;
{$I+}
     checkfile:=c;
     if c=true then close(f);
     if filename='' then checkfile:=false;
end;
procedure calibrate(st:string;s:byte);
var k:byte;
begin
        for k:=1 to (s-length(st)) div 2 do
                write(' ');
        writeln(st);
end;
procedure menu1;
var k:byte;
begin
        clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('MUSIC COMPOSER',x);
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('Hit 1 to read and modify',x);
        calibrate('Hit 2 to create a new file',x);
        calibrate('Hit 3 to rename',x);
        calibrate('Hit 4 to delete',x);
        calibrate('Hit 5 to see the manual',x);
        calibrate('Hit 6 to access user preference',x);
        calibrate('Hit 7 to play sample',x);
        calibrate('Hit 8 to see note chart',x);
        calibrate('Hit esc to exit',x);
        calibrate('UPDATE 1.0',x);
end;
procedure menu2;
var k:byte;
begin
clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('User Preference',x);
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('Hit 1 to use night mode(black background,white text)',x);
        calibrate('Hit 2 to use classic mode(white background,black text)',x);
        if chk=true then
                calibrate('Hit 3 to turn off the number before each row',x)
                else
                calibrate('Hit 3 to turn on the number before each row',x);
        calibrate('Hit 4 to trigger widescreen mode',x);
        calibrate('Press esc to return to menu',x);
end;
procedure menu3;
var k:byte;
begin
        clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('MANUAL',x);
        for k:=1 to x-1 do
                write('-');;
        writeln;
        writeln('Mode 1:');
        writeln('Type "end" to save end exit');
        writeln('Type "edit" to modify a row,then specify the row');
        writeln('Type "del" to delete a row');
        writeln('Type "insert" to insert a blank row,then specify the location');
        writeln('Type "findword" to find a word in the file,then type that word');
        writeln('Type "replace" to replace a word,then type the word that you want to replace,then type the replacement word');
        writeln('Type "play" to play a part,then specify the part you want to play by typing the begin and ending');
        writeln('Type "bpmchange" to change BPM');
        writeln('Press up to scroll up,down to scroll down');
        writeln('Press esc to show command line');
        writeln('Mode 2:');
        writeln('Type "end" to save and exit');
        writeln('Hit enter to go back to menu');
end;
procedure menu4;
var k:byte;
begin
        clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('PLAYING',x);
        for k:=1 to x-1 do
                write('-');
        writeln;
end;
procedure menu5;
var k:byte;
begin
        clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('Note chart',x);
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('C2=65    C3=131    C4=262    C5=523',x);
        calibrate('C#=69    C#=139    C#=277    C#=554',x);
        calibrate('D2=73    D3=147    D4=294    D5=587',x);
        calibrate('D#=78    D#=156    D#=311    D#=622',x);
        calibrate('E2=82    E3=165    E4=330    E5=659',x);
        calibrate('F2=87    F3=175    F4=349    F5=698',x);
        calibrate('F#=92    F#=185    F#=370    F#=740',x);
        calibrate('G2=98    G3=196    G4=392    G5=784',x);
        calibrate('G#=104   G#=208    G#=415    G#=831',x);
        calibrate('A2=110   A3=220    A4=440    A5=880',x);
        calibrate('A#=117   A#=233    A#=466    A#=932',x);
        calibrate('B2=123   B3=247    B4=494    B5=988',x);
        calibrate('Hit enter to return to menu',x);
end;
begin
     x:=80;y:=25;
     textcolor(black);
     textbackground(white);
     clrscr;
     chk:=true;
     repeat
           st:=#0;
           clrscr;
           menu1;
           ch:=readkey;
           if ch='6' then
              repeat
              menu2;
              ch2:=readkey;
              if ch2='3' then
              begin
                   if chk=true then chk:=false
                   else chk:=true;
              end;
              if ch2='1' then
              begin
                   textcolor(white);
                   textbackground(black);
                   lowvideo;
                   clrscr;
              end;
              if ch2='2' then
              begin
                   textcolor(black);
                   textbackground(white);
                   clrscr;
              end;
              if ch2='4' then
                 if (x=80) and (y=25) then
                 begin
                      x:=120;
                      y:=30;
                 end
                 else
                 begin
                      x:=80;
                      y:=25;
                 end;
              until ch2=chr(27);
           if ch='5' then
           repeat
                 menu3;
                 ch:=readkey;
           until ch=chr(13);
           if ch='8' then
           repeat
                 menu5;
                 ch:=readkey;
           until ch=chr(13);
           if ch='7' then
           begin
                readfile;
                writeln('Type the filename');readln(filename);
                filename:=filename+'.mp';
                if checkfile(filename)=false then
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end
                else
                begin
                     n:=0;
                     assign(f,filename);
                     reset(f);
                     readln(f,BPM);
                     repeat
                           n:=n+1;
                           readln(f,a[n]);
                     until (eof(f)) or (n=10000);
                     close(f);
                     clrscr;
                     menu4;
                     for i:=1 to n do
                     begin
                          if a[i]>0 then sound(a[i]);
                          delay(round(1/(BPM/60)*1000));
                          nosound;
                     end;
                end;
           end;
           if ch='4' then
           begin
                readfile;
                writeln('Type the filename');readln(filename);
                filename:=filename+'.mp';
                if checkfile(filename)=false then
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end
                else
                begin
                assign(f,filename);
                erase(f);
                end;
           end;
           if ch='3' then
           begin
                readfile;
                writeln('Type the filename');readln(filename);
                filename:=filename+'.mp';
                if checkfile(filename)=true then
                begin
                     writeln('Type the new filename');readln(filename1);
                     assign(f,filename);
                     rename(f,filename1);
                end
                else
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end;
           end;
           if ch='2' then
           begin
                clrscr;
                writeln('Type the filename');readln(filename);
                filename:=filename+'.mp';
                clrscr;
                writeln('How much BPM?');
                readln(bpm);
                clrscr;
                assign(f,filename);
                rewrite(f);
                writeln(f,bpm);
                close(f);
                repeat
                      assign(f,filename);
                      append(f);
                      readln(st);
                      if st<>'end' then writeln(f,st);
                      close(f);
                until st='end';
           end;
           if ch='1' then
           begin
                readfile;
                st1:=0;st:=#0;
                filename:=#0;m:=1;m1:=1;
                writeln('Type the filename');readln(filename);
                filename:=filename+'.mp';
                if checkfile(filename)=false then
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end
                else
                begin
                     clrscr;
                     while st<>'end' do
                     begin
                          n:=0;
                          assign(f,filename);
                          reset(f);
                          readln(f,BPM);
                          repeat
                                n:=n+1;
                                readln(f,a[n]);
                          until (eof(f)) or (n=10000);
                          close(f);
                          clrscr;
                          ch1:=#0;k:=0;m:=1;
                          if n>y-2 then
                          while ch1<>chr(27) do
                          begin
                               clrscr;
                               writeln('BPM:',bpm);
                               if chk=true then
                                  for i:=m to m+y-3 do
                                  begin
                                       if i<10 then write(i,'   ');
                                       if (10<=i) and (i<100) then write(i,'  ');
                                       if i>=100 then write(i,' ');
                                       write(a[i]);
                                       writeln;
                                  end
                               else
                                   for i:=m to m+y-3 do
                                   begin
                                           write(a[i]);
                                           writeln;
                                   end;
                               ch1:=readkey;
                               if (ch1=#72) and (m>=1) then m:=m-1;
                               if (ch1=#80) and (m+y-3<=n) then m:=m+1;
                               if m=0 then m:=n-y+3;
                               if m=n-y+4 then m:=1;
                          end;
                if n<=y-2 then
                   while ch1<>chr(27) do
                   begin
                        clrscr;
                        writeln('BPM:',bpm);
                        if chk=true then
                        for i:=1 to n do
                        begin
                             if i<10 then write(i,'  ');
                             if (10<=i) then write(i,' ');
                                 write(a[i]);
                             writeln;
                        end
                        else
                            for i:=1 to n do
                            begin
                                     write(a[i]);
                            writeln;
                            end;
                        ch1:=readkey;
                   end;
                write('>');
                readln(st);
                if st='edit' then
                begin
                   write('edit>');
                   readln(k);
                   write('edit>',k,'>');
                   readln(a[k]);
                   assign(f,filename);
                   rewrite(f);
                   writeln(f,BPM);
                   if k<=n then
                      for i:=1 to n do
                          writeln(f,a[i]);
                   if k>n then
                      for i:=1 to k do
                          writeln(f,a[i]);
                   close(f);
                end;
                if st='del' then
                begin
                     write('del>');
                     readln(k);
                     for i:=k to n-1 do
                         a[i]:=a[i+1];
                     n:=n-1;
                     assign(f,filename);
                     rewrite(f);
                     writeln(f,bpm);
                     for i:=1 to n do
                         writeln(f,a[i]);
                     close(f);
                end;
                if st='insert' then
                begin
                     write('insert>');
                     readln(k);
                     for i:=n downto k do
                         a[i+1]:=a[i];
                     a[k]:=0;
                     n:=n+1;
                     assign(f,filename);
                     rewrite(f);
                     writeln(f,bpm);
                     for i:=1 to n do
                         writeln(f,a[i]);
                     close(f);
                end;
                if st='findword' then
                begin
                     write('findword>');
                     readln(st1);
                     clrscr;
                     for i:=1 to n do
                         if st1=a[i] then
                         begin
                              writeln('"',st1,'" available at row ',i);
                              k:=k+1;
                              if k=23 then readkey;
                         end;
                     writeln('"',st1,'" avaliable ',k,' times');
                     readkey;
                end;
                if st='replace' then
                begin
                     write('replace>');
                     readln(st1);
                     writeln;
                     write('replace>',st1,'>');
                     readln(st2);
                     for i:=1 to n do
                         if a[i]=st1 then
                              a[i]:=st2;
                     assign(f,filename);
                     rewrite(f);
                     writeln(f,bpm);
                     for i:=1 to n do
                         writeln(f,a[i]);
                     close(f);
                end;
                if st='play' then
                begin
                     repeat
                           write('play>');
                           readln(st1);
                           write('play>',st1,' to ');
                           readln(st2);
                     until st1<st2;
                     for i:=st1 to st2 do
                         begin
                              if a[i]>0 then sound(a[i]);
                              delay(round(1/(BPM/60)*1000));
                              nosound;
                         end;
                end;
                if st='bpmchange' then
                begin
                     writeln('Type new BPM value');readln(BPM);
                     assign(f,filename);
                     rewrite(f);
                     writeln(f,BPM);
                     for i:=1 to n do
                         writeln(f,a[i]);
                     close(f);
                end;
           end;
     end;
end;
until ch=chr(27);
end.

