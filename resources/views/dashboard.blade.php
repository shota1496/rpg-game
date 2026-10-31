<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        
<!-- ★ ここからRPGステータス表示パネルを追加 -->
            @if($player)
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg mb-6">
                    <div class="p-6 text-gray-900">
                        <h3 class="text-lg font-bold mb-4">⚔️ 冒険者ステータス</h3>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
                            <div class="bg-gray-100 p-4 rounded-lg">
                                <p class="text-sm text-gray-500">名前</p>
                                <p class="text-xl font-bold">{{ $player->name }}</p>
                            </div>
                            <div class="bg-gray-100 p-4 rounded-lg">
                                <p class="text-sm text-gray-500">レベル</p>
                                <p class="text-xl font-bold">Lv. {{ $player->level }}</p>
                            </div>
                            <div class="bg-gray-100 p-4 rounded-lg">
                                <p class="text-sm text-gray-500">HP</p>
                                <p class="text-xl font-bold">{{ $player->hp }} / {{ $player->max_hp }}</p>
                            </div>
                            <div class="bg-gray-100 p-4 rounded-lg">
                                <p class="text-sm text-gray-500">所持金</p>
                                <p class="text-xl font-bold">🪙 {{ $player->gold }} G</p>
                            </div>
                        </div>
                    </div>
                </div>
            @endif
            <!-- ★ ここまで -->
        
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    {{ __("You're logged in!") }}
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
