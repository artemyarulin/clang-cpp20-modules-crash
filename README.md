# Clang C++ 20 modules crash

Tested on:
- 9 - crash
- Latest dev `clang version 11.0.0-++20200305081720+a31130f6fcf-1~exp1~20200305073037.129` - crash
- Works fine on `Apple clang version 11.0.0 (clang-1100.0.33.8)`

```
clang version 11.0.0-++20200305081720+a31130f6fcf-1~exp1~20200305073037.129
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
clang++ -std=c++2a -fmodules-ts -fprebuilt-module-path=. --precompile -x c++-module m.cc -o m.pcm
clang++ -std=c++2a -fmodules-ts -fprebuilt-module-path=. -c m.pcm -o m.o
clang++ -std=c++2a -fmodules-ts -fprebuilt-module-path=. m.o main.cc -o app
Stack dump:
0.	Program arguments: /usr/lib/llvm-11/bin/clang -cc1 -triple x86_64-pc-linux-gnu -emit-obj -mrelax-all -disable-free -disable-llvm-verifier -discard-value-names -main-file-name main.cc -mrelocation-model static -mthread-model posix -mframe-pointer=all -fmath-errno -fdenormal-fp-math=ieee,ieee -fno-rounding-math -masm-verbose -mconstructor-aliases -munwind-tables -target-cpu x86-64 -dwarf-column-info -fno-split-dwarf-inlining -debugger-tuning=gdb -resource-dir /usr/lib/llvm-11/lib/clang/11.0.0 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9 -internal-isystem /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/backward -internal-isystem /usr/local/include -internal-isystem /usr/lib/llvm-11/lib/clang/11.0.0/include -internal-externc-isystem /usr/include/x86_64-linux-gnu -internal-externc-isystem /include -internal-externc-isystem /usr/include -std=c++2a -fdeprecated-macro -fdebug-compilation-dir /src -ferror-limit 19 -fmessage-length 0 -fgnuc-version=4.2.1 -fmodules-ts -fno-implicit-modules -fprebuilt-module-path=. -fobjc-runtime=gcc -fcxx-exceptions -fexceptions -fdiagnostics-show-option -faddrsig -o /tmp/main-c8e327.o -x c++ main.cc
1.	main.cc:6:8: at annotation token
2.	main.cc:5:23: parsing function body 'main'
3.	main.cc:5:23: in compound statement ('{}')
 #0 0x00007fe506a2c3bf llvm::sys::PrintStackTrace(llvm::raw_ostream&) (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0x9ab3bf)
 #1 0x00007fe506a2a670 llvm::sys::RunSignalHandlers() (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0x9a9670)
 #2 0x00007fe506a2c985 (/lib/x86_64-linux-gnu/libLLVM-11.so.1+0x9ab985)
 #3 0x00007fe506073540 __restore_rt (/lib/x86_64-linux-gnu/libpthread.so.0+0x15540)
 #4 0x00007fe50412b863 clang::TypeLoc::getNextTypeLocImpl(clang::TypeLoc) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0xc87863)
 #5 0x00007fe50412c8ab clang::TypeLoc::getBeginLoc() const (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0xc888ab)
 #6 0x00007fe503f5f046 clang::TemplateTypeParmDecl::getDefaultArgumentLoc() const (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0xabb046)
 #7 0x00007fe5047e48cf (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x13408cf)
 #8 0x00007fe5047da3ea clang::Sema::CheckTemplateArgumentList(clang::TemplateDecl*, clang::SourceLocation, clang::TemplateArgumentListInfo&, bool, llvm::SmallVectorImpl<clang::TemplateArgument>&, bool, bool*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x13363ea)
 #9 0x00007fe5047d8cd2 clang::Sema::CheckTemplateIdType(clang::TemplateName, clang::SourceLocation, clang::TemplateArgumentListInfo&) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1334cd2)
#10 0x00007fe5047dc2ec clang::Sema::ActOnTemplateIdType(clang::Scope*, clang::CXXScopeSpec&, clang::SourceLocation, clang::OpaquePtr<clang::TemplateName>, clang::IdentifierInfo*, clang::SourceLocation, clang::SourceLocation, llvm::MutableArrayRef<clang::ParsedTemplateArgument>, clang::SourceLocation, bool, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x13382ec)
#11 0x00007fe503dfc07e clang::Parser::AnnotateTemplateIdTokenAsType(clang::CXXScopeSpec&, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x95807e)
#12 0x00007fe503e0b72e clang::Parser::TryAnnotateTypeOrScopeTokenAfterScopeSpec(clang::CXXScopeSpec&, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x96772e)
#13 0x00007fe503e0bad4 clang::Parser::TryAnnotateTypeOrScopeToken() (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x967ad4)
#14 0x00007fe503dfdc0f clang::Parser::isCXXDeclarationSpecifier(clang::Parser::TPResult, bool*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x959c0f)
#15 0x00007fe503dfd657 clang::Parser::isCXXSimpleDeclaration(bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x959657)
#16 0x00007fe503de8efd clang::Parser::ParseStatementOrDeclarationAfterAttributes(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*, clang::Parser::ParsedAttributesWithRange&) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x944efd)
#17 0x00007fe503de8a2a clang::Parser::ParseStatementOrDeclaration(llvm::SmallVector<clang::Stmt*, 32u>&, clang::Parser::ParsedStmtContext, clang::SourceLocation*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x944a2a)
#18 0x00007fe503df0170 clang::Parser::ParseCompoundStatementBody(bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x94c170)
#19 0x00007fe503df10b5 clang::Parser::ParseFunctionStatementBody(clang::Decl*, clang::Parser::ParseScope&) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x94d0b5)
#20 0x00007fe503e09ed6 clang::Parser::ParseFunctionDefinition(clang::ParsingDeclarator&, clang::Parser::ParsedTemplateInfo const&, clang::Parser::LateParsedAttrList*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x965ed6)
#21 0x00007fe503d732ea clang::Parser::ParseDeclGroup(clang::ParsingDeclSpec&, clang::DeclaratorContext, clang::SourceLocation*, clang::Parser::ForRangeInit*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x8cf2ea)
#22 0x00007fe503e090cd clang::Parser::ParseDeclOrFunctionDefInternal(clang::Parser::ParsedAttributesWithRange&, clang::ParsingDeclSpec&, clang::AccessSpecifier) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x9650cd)
#23 0x00007fe503e08adc clang::Parser::ParseDeclarationOrFunctionDefinition(clang::Parser::ParsedAttributesWithRange&, clang::ParsingDeclSpec*, clang::AccessSpecifier) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x964adc)
#24 0x00007fe503e07c5c clang::Parser::ParseExternalDeclaration(clang::Parser::ParsedAttributesWithRange&, clang::ParsingDeclSpec*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x963c5c)
#25 0x00007fe503e05f9c clang::Parser::ParseTopLevelDecl(clang::OpaquePtr<clang::DeclGroupRef>&, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x961f9c)
#26 0x00007fe503d5ed3d clang::ParseAST(clang::Sema&, bool, bool) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x8bad3d)
#27 0x00007fe505232608 clang::FrontendAction::Execute() (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1d8e608)
#28 0x00007fe5051e9fc1 clang::CompilerInstance::ExecuteAction(clang::FrontendAction&) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1d45fc1)
#29 0x00007fe50529687f clang::ExecuteCompilerInvocation(clang::CompilerInstance*) (/lib/x86_64-linux-gnu/libclang-cpp.so.11+0x1df287f)
#30 0x00000000004122af cc1_main(llvm::ArrayRef<char const*>, char const*, void*) (/usr/lib/llvm-11/bin/clang+0x4122af)
#31 0x0000000000410601 (/usr/lib/llvm-11/bin/clang+0x410601)
#32 0x000000000040e6c1 main (/usr/lib/llvm-11/bin/clang+0x40e6c1)
#33 0x00007fe502f811e3 __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x271e3)
#34 0x000000000040d8de _start (/usr/lib/llvm-11/bin/clang+0x40d8de)
clang: error: unable to execute command: Segmentation fault
clang: error: clang frontend command failed due to signal (use -v to see invocation)
clang version 11.0.0-++20200305081720+a31130f6fcf-1~exp1~20200305073037.129
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
clang: note: diagnostic msg: PLEASE submit a bug report to https://bugs.llvm.org/ and include the crash backtrace, preprocessed source, and associated run script.
clang: note: diagnostic msg:
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/main-a0e4ae.cpp
clang: note: diagnostic msg: /tmp/main-a0e4ae.sh
clang: note: diagnostic msg:

********************
```
