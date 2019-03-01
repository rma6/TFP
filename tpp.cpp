/*Translator Prism Prism V1.0
By Rafael Marinho*/
#include <cstdio>
#include <cstdlib>
#include <string>
#include <cstring>
#include <iostream>
#include <regex>
#include <vector>

using namespace std;

int main(int nNumberofArgs, char* pszArgs[])
{
    if(pszArgs[1] == NULL || pszArgs[2] == NULL)
    {
        cout <<"Missing parameters";
        exit(0);
    }

    int enable=0, fsize, i, j, k, bkr=0, bkl=0, N1b, N1e, N2b, N2e, N1, N2, varset=0;
    string rep;
    string var;
    char c_rep[5];
    FILE* f = fopen(pszArgs[1],"r");
    fseek(f, 0, SEEK_END);
    fsize = ftell(f);
    rewind(f);
    char* in = (char*) malloc(fsize + 1);
    fread(in, fsize, 1, f);
    fclose(f);
    in[fsize] = 0;
    string input(in);

    //Translates ".."
    for(i=0;input[i]!=0;i++)
    {
        if(input[i]=='[')
        {
            bkl=1;
        }
        if(input[i]==']')
        {
            bkr=1;
        }
        if(bkr && bkl)
        {
            enable=1;
            bkr=0;
            bkl=0;
        }
        if(input[i]=='\n')
        {
            enable=0;
            bkr=0;
            bkl=0;
        }
        if(enable==1)
        {
            if(input[i]=='.' && input[i+1]=='.')
            {
                for(N1b=i-1; isdigit(input[N1b-1]); N1b--)
                for(N2e=i+1; isdigit(input[N2e+1]); N2e++);
                N2b=i+2;
                N1e=i-1;
                sscanf(input.substr(N1b,N1e).c_str(), "%i", &N1);
                sscanf(input.substr(N2b,N2e).c_str(), "%i", &N2);
                rep.clear();
                for(j=N1+1; j<N2; j++)
                {
                    sprintf(c_rep,",%i", j);
                    rep+=c_rep;
                }
                rep.push_back(',');
                input.erase(i, 2);
                input.insert(i, rep);
            }
        }
    }

    //Translates ","
    for(i=0;input[i]!=0;i++)
    {
        if(input[i]=='[')
        {
            bkl=1;
        }
        if(input[i]==']')
        {
            bkr=1;
        }
        if(bkr && bkl)
        {
            enable=1;
            bkr=0;
            bkl=0;
        }
        if(input[i]=='\n')
        {
            varset=0;
            enable=0;
            bkr=0;
            bkl=0;
        }
        if(input[i]=='-' && input[i+1]=='>')
        {
            enable=2;
        }
        if(enable==1)
        {
            if(!varset)//sets replacing variable
            {
                var.clear();
                for(j=input.find('&', i)+2; input.at(j)!='=' && input.at(j)!='!'; j++)
                {
                    var.push_back(input[j]);
                }
                rep.clear();
                if(input.at(j)=='=')
                {
                    rep+=" | ";
                    rep+=var;
                    rep.push_back('=');
                }
                else
                {
                    rep+=" & ";
                    rep+=var;
                    rep+="!=";
                }
                varset=1;
            }
            if(input[i]==',')
            {
                input.erase(i,1);
                input.insert(i, rep);
            }
        }
        if(enable==2)
        {
            if(input[i]==',')
            {
                j=input.find('?');
                for(N1e=j+1; isdigit(input[N1e+1]); N1e++);
                N1b=j+1;
                sscanf(input.substr(N1b,N1e).c_str(), "%i", &N1);
                rep.clear();
                sprintf(c_rep,"?%i:", N1);
                rep+=c_rep;
                rep+=var;
                rep.push_back('=');
                input.erase(i,1);
                input.insert(i, rep);
            }
        }
    }    

    //Erases dummys
    while((i=input.find("[dummy]"))!=string::npos)
    {
        j=input.find("\n", i);
        input.erase(i-2, j-i+3);
    }

    //replaces nondeterministic for mdp
    i=input.find("nondeterministic");
    input.erase(i,16);
    input.insert(i,"mdp");

    //adds () between & ->
    regex e1("&(.+)\\->");
    input = regex_replace(input, e1, "& ($1) ->");

    //capture BLOCK numbers and [block] content
    vector<string> blockNumbers;
    regex e2("block<\\-(?!block)(.+)");
    smatch m2;
    string inputCopy = input;
    while(regex_search(inputCopy, m2, e2))
    {
        blockNumbers.push_back(m2.str(1));
        inputCopy = m2.suffix().str();
    }

    string blockContent;
    int insertBlockPos;
    regex e3("\\[block\\](.+\\n)");
    smatch m3;
    regex_search(input, m3, e3);
    insertBlockPos=m3.position()+m3[0].length();
    blockContent=m3.str(1);

    //adds module BLOCK content
    for(int i=0; i<blockNumbers.size(); i++)
    {
        input.insert(insertBlockPos, string("\t[")+blockNumbers[i]+string("]")+blockContent);
        insertBlockPos+=blockNumbers[i].length()+blockContent.length()+3;
    }

    //remove system blocks
    while((i=input.find(" { dummy<-dummy"))>0)
    {
        j=input.find("}", i);
        input.erase(i, j-i+1);
    }
    i=input.find(" { block<-block");
    j=input.find("}", i);
    input.erase(i, j-i+1);

    //writes to my file
    f = fopen(strcat(pszArgs[2],"/model_out.pm"),"w");
    fprintf(f, "%s", input.c_str());
    return 0;
}