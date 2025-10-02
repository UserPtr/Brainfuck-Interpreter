import std.stdio : write, writeln, writefln, readln, stderr;
import std.conv : to;
import std.file : readText;


void interpretation(string sourceCode) {
    char[32000] memory = 0;
    const size_t LEN = sourceCode.length-1;
    int pointer = 0;
    size_t pos = 0;

    while(pos < LEN) {
        switch(sourceCode[pos]) {
            case '<':
                --pointer; 
                ++pos;
                break;

            case '>': 
                ++pointer; 
                ++pos;
                break;

            case '+': 
                ++memory[pointer];
                ++pos;
                break;

            case '-': 
                --memory[pointer];
                ++pos;
                break;

            case '[':
                if(!memory[pointer]) {
                    while(sourceCode[pos] != ']') {
                        ++pos;
                    }
                }
                ++pos;
                break;
                
            case ']':
                if(memory[pointer]) {
                    while(sourceCode[pos] != '[') {
                        --pos;
                    }
                }
                ++pos;
                break;

            case ',':
                memory[pointer] = readln()[0];
                ++pos;
                break;

            case '.':
                write(to!char(memory[pointer]));
                ++pos;
                break;

            default:
                ++pos;
                break;
        }
    }
}

void main(string[] args) {
    if(args.length < 2) {
        writefln("Usage: %s <filename.bf>", args[0]);        
        return;
    }

    try {
        string sourceCode = readText(args[1]);
        interpretation(sourceCode);
    } catch(Exception e) {
        stderr.writeln("Error", e);
    }
}