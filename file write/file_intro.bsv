package file_intro;
    module files(Empty);
    
        Reg#(int) cnt <- mkReg(0);
        Reg#(File) fh <- mkReg(InvalidFile) ;
        Reg#(File) fmcd <- mkReg(InvalidFile) ;
        Reg#(Bit#(1)) done <-mkReg(0);
        
        rule open (cnt == 0 ) ;
            // Open the file and check for proper opening
            String dumpFile = "dump_file1.dat" ;
            File lfh <- $fopen( dumpFile, "w" ) ;
            if ( lfh == InvalidFile )
            begin
            $display("cannot open %s", dumpFile);
            $finish(0);
            end
            cnt <= 1 ;
            fh <= lfh ;
            // Save the file in a Register
        endrule
        
        rule dump (cnt > 0 );
            $fwrite( fh , "cnt = %0d\n", cnt);
     
            //dump_file2.dat
            cnt <= cnt + 1;
            done <= 1;
        endrule
        
        rule ends(done == 1);
            $fclose(fh);
            // $fclose(fmcd);
        endrule
        
    endmodule
endpackage
