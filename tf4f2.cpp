/*Translator FDR4 FDR2 V0.3
By Rafael Marinho*/
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <cstring>
#include <fstream>

using namespace std;

int main(int nNumberofArgs, char* pszArgs[])
{
    if(pszArgs[1]==NULL || pszArgs[2]==NULL)//pname folder
    {
        cout <<"Missing parameters";
        exit(0);
    }
    int ne=0;
    char stemp[strlen(pszArgs[2])+1];
    strcpy(stemp,pszArgs[2]);
    ifstream flist(strcat(stemp,"/temp.txt"));
    string filename;
    while(getline(flist, filename))
    {
        if(filename.find("temp.txt") != string::npos)
        {
            continue;
        }
        int fsize, pos=0, end_l, ko, kc, cn, ls;
        FILE* f = fopen(filename.c_str(),"r");
        fseek(f, 0, SEEK_END);
        fsize = ftell(f);
        rewind(f);
        char* in = (char*) malloc(fsize + 1);
        fread(in, fsize, 1, f);
        fclose(f);
        in[fsize] = 0;
        string input(in);

        //removes useless assertions
        pos=input.find("assert ");
        while(pos!=string::npos)
        {
            int posn = input.find("\n", pos);
            input.erase(pos, posn-pos+1);
            pos=input.find("assert ");
        }

        if(filename.find(pszArgs[1])!=string::npos && filename.find("assertions")!=string::npos)
        {
            input.append("\nassert ");
            input.append(pszArgs[1]);
            input.append("_O ");
            input.append("[T= ");
            input.append(pszArgs[1]);
            input.append("_O ");
            input.append(":[probabilist translation]");
        }

        //fixes nametype string = LSeq(Char,2)
        pos=input.find("LSeq(Char,2)");
        if(pos!=string::npos)
        {
            input.erase(pos, 12);
            input.insert(pos, "nat");
        }

        //fixes nametype real = {0,1}
        pos=input.find("real = {0,1}");
        if(pos!=string::npos)
        {
            input.erase(pos, 12);
            input.insert(pos, "real = {0, 1, 90, 180, -90}");
        }

        //fixes core_defs
        pos=input.find("include \"defs/core_defs.csp\"");
        if(pos!=string::npos)
        {
            end_l=input.find("\n", pos);
            string subs = input.substr(pos, end_l-pos);
            input.erase(pos, end_l-pos);
            subs.push_back('\n');
            input.insert(0, subs);
        }

        //fixes includes
        pos=0;
        while(pos!=string::npos)
        {
            pos=input.find("include", pos);
            end_l=input.find("\n", pos);
            if(end_l!=string::npos)
            {
                input.insert(end_l, "\n");
            }
            pos=end_l;
        }

        //fixes strings
        for(pos=input.find("__NULLTRANSITION__"), ne++; pos!=string::npos; pos=input.find("__NULLTRANSITION__"))
        {
            input.erase(pos, 18);
            input.insert(pos,"NT"+to_string(ne));
        }
        if(input.find("include")==string::npos)
        {
            pos=0;
            cn=1;
            for(pos=input.find("\"", pos); pos!=string::npos; pos=input.find("\"", pos))
            {
                input.erase(pos,1);
                if(cn)
                {
                    input.insert(pos,"R");
                }
                cn=1-cn;
            }
            pos=0;
            while(pos!=string::npos)
            {
                ko=input.find("= {\n");
                if(ko!=string::npos)
                {
                    for(ls=ko; input[ls]!='\n' && ls>=0; ls--);
                    ls++;
                    input.insert(ls, "datatype ");
                    ko=input.find("= {\n", ls);
                    input.erase(ko+1, 4);
                    kc=input.find("}", ko);
                    for(pos=input.find(",", ko); pos<kc; pos=input.find(",\n", pos))
                    {
                        input.erase(pos, 3);
                        input.insert(pos, " | ");
                    }
                    pos=input.find("\n", ko);
                    input.erase(pos, 2);
                }
                else
                {
                    break;
                }
            }
        }

        //write changes to file
        char stemp2[strlen(pszArgs[2])+1];
        strcpy(stemp2,pszArgs[2]);
        string outfp(strcat(stemp2,"/out/"));
        outfp.append(filename.substr(filename.find(pszArgs[2])+strlen(pszArgs[2]), string::npos));
        f = fopen(outfp.c_str(),"w");
        fprintf(f, "%s", input.c_str());
        fclose(f);
    }
}